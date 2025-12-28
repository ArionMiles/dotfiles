#!/usr/bin/env bash

# Kill process running on a given port
function killp() {
    lsof -i :$1 | awk 'NR>1 {print $2}' | xargs kill -9
}
