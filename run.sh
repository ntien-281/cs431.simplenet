datapath=./mvtec
datasets=('screw' 'pill' 'capsule' 'carpet' 'grid' 'tile' 'wood' 'zipper' 'cable' 'toothbrush' 'transistor' 'metal_nut' 'bottle' 'hazelnut' 'leather')
dataset_flags=($(for dataset in "${datasets[@]}"; do echo '-d '"${dataset}"; done))

python main.py \
--gpu 0 \
--seed 0 \
--log_group simplenet_mvtec \
--log_project MVTecAD_Results \
--results_path results_adapted_size_96 \
--run_name run \
--test \
--save_segmentation_images \
net \
-b wideresnet50 \
-le layer2 \
-le layer3 \
--pretrain_embed_dimension 1536 \
--target_embed_dimension 96 \
--patchsize 3 \
--meta_epochs 10 \
--embedding_size 256 \
--gan_epochs 4 \
--noise_std 0.015 \
--dsc_hidden 1024 \
--dsc_layers 2 \
--dsc_margin .5 \
--pre_proj 1 \
dataset \
--batch_size 8 \
--resize 224 \
--imagesize 256 "${dataset_flags[@]}" mvtec $datapath
