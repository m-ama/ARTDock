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

### Running with GUI
ARTDock can be called with a GUI using X11 window forwarding. Windows users
can use [Xming X Server](https://sourceforge.net/projects/xming/) for X11
forwarding, while Mac users can use [XQuartz](https://www.xquartz.org/)

The remaning portion of this section will show the steps to run art GUI
on a Mac, using instructions posted on the page [How to show X11
windows with Docker on Mac](https://medium.com/@mreichelt/how-to-show-x11-windows-within-docker-on-mac-50759f4b65cb).

1. Install XQuartz with [Homebrew](https://brew.sh/)
    ```
    brew cask install xquartz
    ```

2. Open XQuartz with `open -a XQuartz`, then enable ‘Allow connections from network clients’ in XQuartz's preferences [Mac menu bar > XQuartz > Preferences > Security].

3. Quit and restart XQuartz for these settings to take effect.

4. Allow localhost for X11 forwarding:
    ```
    xhost + 127.0.0.1
    ```

5. Run ARTDock with the `-e DISPLAY` flag:
    ```
    docker run -it --rm \
    -e DISPLAY=host.docker.internal:0  \
    artdock art2  
    ```
 Alternatively, you may execute the bash file with `art2gui` to run
 this command on Mac.

### Running w/o GUI
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