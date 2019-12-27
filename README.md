# ARTDock
<a href="https://circleci.com/gh/m-ama/ARTDock">
    <img src="https://img.shields.io/circleci/build/github/m-ama/ARTDock?label=circleci">
</a>

ArtDock is a Docker image containing Babak Ardekani's [Automatic Registration Toolbox](https://www.nitrc.org/projects/art) for cross-compatibility and ease-of-usage.

## Docker Installation
The first step is actually installing Docker. One can easily download and install this from the [Docker Desktop](https://www.docker.com/products/docker-desktop) page by following instructions for respective platforms.

## Building ARTDock
1. Using terminal, change directory with 
```
cd [clone directory]
```

2. Then, build the dockerfile with
```
docker build -t artdock .
```

Until this repo is made availble on DockerHub, this is the only way to build this Docker image.

## Running ARTDock
While ARTDock is in experimental stages, one can run ARTdock with the following syntax:
```
docker run -it --rm -v [folder to mount]:[mount point] artdock
```

This command will activate the container with contents of `/[folder to mount]` in `/[mount point]`. The three primary commands included in this Docker images are: `3dwarper`, `applywarp3d`, and `acpcdetect`.

### Example:
One can run automated non-linear registration with the following command:
```
3dwarper -v -o [mount point]/output/transformed_img.nii -sub /[mount point]/input/subject.nii -trg /[mount point]/input/target.nii
```

A real transformation commad from activation to transformation is:
```
docker run -it --rm -v /Users/sid/Downloads/Mouse/data:/data artdock
```
```
3dwarper -v -acpc \
-o /data/out/w1t2m8.nii \
-sub /data/same_mice_T1_2/w1t2m8/rrdki_0.nii \
-trg /data/same_mice_T1_2/w1t1m8/rrdki_0.nii
```