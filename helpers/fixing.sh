#!/bin/bash

# Sytle list autocomplete fix color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
