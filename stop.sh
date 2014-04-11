#!/bin/bash
. ./common.sh

id=$( cat ./running-id )
docker stop $id
