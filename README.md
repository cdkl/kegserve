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
