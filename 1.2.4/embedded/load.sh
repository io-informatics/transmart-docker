#!/bin/bash
cd /opt/transmart-data-1.2.4; . ./vars && make -C samples/postgres load_$1
