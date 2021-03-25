FROM nikolaik/python-nodejs:python3.7-nodejs12-alpine as base
RUN apk add -U --no-cache --virtual .build-deps  \
    build-base \
    clang \
    clang-dev \
    cmake \
    g++ \
    jpeg-dev \
    libpng-dev \
    libgcc \
    linux-headers \
    make \
    gcc \
    jpeg \
    libjpeg \
    libpng
RUN pip install numpy

FROM base as builder
RUN wget -O opencv-4.2.0.zip https://codeload.github.com/opencv/opencv/zip/4.2.0 \
&& unzip opencv-4.2.0.zip
RUN cd opencv-4.2.0 && mkdir build && cd build  && cmake \
        -DCMAKE_BUILD_TYPE=RELEASE \
        -DCV_TRACE=OFF \
        -DBUILD_opencv_java=OFF \
        -DANDROID=OFF \
        -DWITH_CUDA=OFF \
        -DWITH_CUBLAS=OFF \
        -DWITH_CUFFT=OFF \
        -DWITH_WIN32UI=OFF \
        -DENABLE_AVX=OFF \
        -DENABLE_AVX2=OFF \
        -DENABLE_SSE41=OFF \
        -DENABLE_SSE42=OFF \
        -DENABLE_SSSE3=OFF \
        -DWITH_OPENGL=OFF \
        -DWITH_GTK=OFF \
        -DWITH_VTK=OFF \
        -DWITH_HALIDE=OFF \
        -DWITH_OPENVX=OFF \
        -DWITH_QUIRC=OFF \
        -DWITH_GSTREAMER=OFF \
        -DWITH_OPENNI2=OFF \
        -DWITH_PVAPI=OFF \
        -DWITH_ARAVIS=OFF \
        -DWITH_AVFOUNDATION=OFF \
        -DWITH_OPENCL=OFF \
        -DWITH_OPENCL_SVM=OFF \
        -DWITH_VULKAN=OFF \
        -DWITH_INF_ENGINE=OFF \
        -DWITH_DIRECTX=OFF \
        -DWITH_TBB=OFF \
        -DWITH_JPEG=ON \
        -DWITH_WEBP=OFF \
        -DWITH_1394=OFF \
        -DWITH_TIFF=OFF \
        -DWITH_PNG=ON \
        -DWITH_QT=OFF \
        -DWITH_JASPER=OFF \
        -DWITH_OPENEXR=OFF \
        -DWITH_GDAL=OFF \
        -DWITH_IPP=OFF \
        -DWITH_EIGEN=OFF \
        -DWITH_V4L=OFF \
        -DWITH_DSHOW=OFF \
        -DWITH_MSMF=OFF \
        -DWITH_MFX=OFF \
        -DWITH_GPHOTO2=OFF \
        -DWITH_XIMEA=OFF \
        -DWITH_XINE=OFF \
        -DWITH_LIBREALSENSE=OFF \
        -DWITH_INTELPERC=OFF \
        -DWITH_FFMPEG=OFF \
        -DWITH_IMGCODEC_HDR=OFF \
        -DWITH_IMGCODEC_SUNRASTER=OFF \
        -DWITH_IMGCODEC_PXM=OFF \
        -DWITH_IMGCODEC_PFM=OFF \
        -DENABLE_PRECOMPILED_HEADERS=NO \
        -DBUILD_opencv_python2=OFF \
        -DBUILD_opencv_python3=ON \
        -DBUILD_opencv_video=OFF \
        -DBUILD_opencv_videoio=OFF \
        -DBUILD_opencv_visualisation=OFF \
        -DBUILD_opencv_highgui=OFF \
        -DBUILD_opencv_ml=OFF \
        -DBUILD_opencv_dnn=OFF \
        -DBUILD_opencv_videoio_plugins=OFF \
        -DBUILD_opencv_calib3d=OFF \
        -DBUILD_opencv_gapi=OFF \
        -DBUILD_libprotobuf=OFF \
        -DBUILD_ittnotify=OFF \
        -DBUILD_opencv_flann=OFF \
        -DBUILD_opencv_features2d=OFF \
        -DBUILD_opencv_photo=OFF \
        -DBUILD_ade=OFF \
        -DBUILD_DOCS=OFF \
        -DBUILD_PERF_TESTS=OFF \
        -DBUILD_TESTS=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DINSTALL_PYTHON_EXAMPLES=OFF \
        -DINSTALL_C_EXAMPLES=OFF \
        -DWITH_PTHREADS_PF=OFF \
        -DWITH_PROTOBUF=OFF \
     .. && \
     make -j16 && make -j16 install

FROM base
COPY --from=builder /usr/local /usr/local

