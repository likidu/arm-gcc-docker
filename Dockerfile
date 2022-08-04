FROM ubuntu:22.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget python3 python3-pip cmake git ninja-build && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    # Make python3 as default python
    update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
    # Make pip3 as default pip
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

ARG ARM_GCC_VERSION=11.2
ARG ARM_GCC_BUILD=2022.02
ARG TEMP_ARCHIVE_FILE_NAME=archive.tar.xz

RUN wget -qO ${TEMP_ARCHIVE_FILE_NAME} "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_GCC_VERSION}-${ARM_GCC_BUILD}/binrel/gcc-arm-${ARM_GCC_VERSION}-${ARM_GCC_BUILD}-x86_64-arm-none-eabi.tar.xz" && \
    tar -xf ${TEMP_ARCHIVE_FILE_NAME} -C /opt && \
    rm ${TEMP_ARCHIVE_FILE_NAME}

ENV PATH=/opt/gcc-arm-${ARM_GCC_VERSION}-${ARM_GCC_BUILD}-x86_64-arm-none-eabi/bin:$PATH

WORKDIR /builds