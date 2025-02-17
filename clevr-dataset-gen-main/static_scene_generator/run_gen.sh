#!/bin/bash

start_idx=0
num_scenes_per_batch=1   # Set this to <=200 to avoid subtle run_time errors.
counter=0
num_batches=1    # number of generated scenes = (num_batches - counter) * num_scenes_per_batch
num_views=4
while [ $counter -lt $num_batches ]
do
  /home/shubham/Downloads/blender-2.79-linux-glibc219-x86_64/blender --background --python render_images_mv.py -- --use_gpu 0 \
  --start_idx $(($start_idx+$counter * $num_scenes_per_batch)) --num_scenes $num_scenes_per_batch --num_views $num_views \
  --width 480 --height 320 --min_pixels_per_object 48 --min_objects 4 --max_objects 6 \
  --properties_json data/properties_customised.json
  ((counter++))
  sleep 2
done

sleep 2
python postproc_masks.py --num_views $num_views
