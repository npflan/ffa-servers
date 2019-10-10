#!/bin/bash
[[ -f dm_box_bs_final.zip ]] || curl https://files.gamebanana.com/maps/dm_box_bs_final.zip || (echo "couldn't download dm_box_bs_final" && exit 1)

[[ -f dm_killbox_kbh.zip ]] || curl https://files.gamebanana.com/maps/dm_killbox_kbh.zip || (echo "couldn't download dm_killbox_kbh" && exit 1)
