# README

## Kegserve

A simple service for specifying keg tap contents, intended to be read and presented by a Magtag device.

### History

This is a Rails rewrite of a Laravel service that was cobbled together in the past. The main goals here: 

* Replicate the behaviour of defining beverages, and setting tap assignments, so that a display device can fetch them.
* Containerize the whole thing and push out to Docker Hub so that my [homelab definition](https://github.com/cdkl/homelab) can deploy it to the local k3s cluster.
* Keep data storage simple (we're talking literally bytes here) but make sure the sqlite db is persisted properly in deployment (not done yet.)

### Application

Currently serves /taps and /beers endpoints.

Still needs a root page.

Also has JSON read access to taps (and their beverages) via /api/v1/taps

### Setup

Running locally requires nothing more than normal Rails app setup (though I haven't exercised this fresh.)

The github workflow for docker-image shows how it is built and pushed out to docker hub. This image requires specifying the correct `RAILS_MASTER_KEY` as an environment variable at runtime. If you fork this, you will have to create this yourself (it will live in `config/master.key`.)

### Container Deployment

#### Required Environment Variables

- `RAILS_MASTER_KEY`: Your Rails master key (from config/master.key)
- `SQLITE_DB_PATH`: Path to SQLite database file (default: /data/production.sqlite3)

#### Docker

```bash
# Build the container
docker build -t kegserve .

# Run with local directory mount
mkdir -p ~/kegserve_data
docker run -d \
  -p 80:80 \
  -e RAILS_MASTER_KEY=$(cat config/master.key) \
  -e SQLITE_DB_PATH=/data/production.sqlite3 \
  -v ~/kegserve_data:/data \
  --name kegserve \
  kegserve
```

#### Kubernetes/k3s Deployment

1. Create a PersistentVolume and PersistentVolumeClaim:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: kegserve-sqlite-pv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-path
  local:
    path: /path/to/your/data
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - your-node-name

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: kegserve-sqlite-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: local-path
  resources:
    requests:
      storage: 1Gi
```

2. Deploy the application:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kegserve
spec:
  template:
    spec:
      containers:
      - name: kegserve
        image: kegserve:latest
        env:
        - name: RAILS_MASTER_KEY
          valueFrom:
            secretKeyRef:
              name: kegserve-secrets
              key: rails-master-key
        - name: SQLITE_DB_PATH
          value: /data/production.sqlite3
        volumeMounts:
        - name: sqlite-data
          mountPath: /data
      volumes:
      - name: sqlite-data
        persistentVolumeClaim:
          claimName: kegserve-sqlite-pvc
```

### Data Persistence

The application uses SQLite for data storage. The database file is stored in `/data/production.sqlite3` inside the container, which should be mounted to a persistent volume.

- In Docker: Use a volume mount (-v flag) or named volume
- In k3s: Use a PersistentVolume/PersistentVolumeClaim
- The database will be automatically initialized if it doesn't exist
- Migrations run automatically on container start

### API Endpoints

Currently serves:
- Web UI: `/taps` and `/beverages`
- API: `/api/v1/taps` for JSON access to taps and their beverages
