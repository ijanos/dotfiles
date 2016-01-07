#!/usr/bin/bash
rsync -axv --info=progress2 \
           --exclude .m2/repository \
           --exclude .config/google-chrome \
           --exclude 'VirtualBox VMs' \
           --exclude '.cache'  \
   /home/ij/ /run/media/ij/IJanos\ backup/`date +"%Y-%m-%d"`/

rsync -a --info=progress2 \
   VirtualBox\ VMs/NOKWIN \
   /run/media/ij/IJanos\ backup/vm-`date +"%Y-%m-%d"`
