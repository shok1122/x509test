#!/bin/sh

openssl req -text -noout -verify -in "$1"

