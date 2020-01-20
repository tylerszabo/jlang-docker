ARG J_OUTPUT_DIR=/j_built
ARG J_INSTALL_DIR=/j

FROM alpine:latest as builder

LABEL maintainer="Tyler Szabo <tyler@szabomail.ca>"

ARG GIT_URL=https://github.com/jsoftware/jsource.git
ARG GIT_BRANCH=j901-release-c
ARG SRC_DIR=/jsource
ARG J_OUTPUT_DIR

RUN apk --no-cache add \
    bash \
    build-base \
    clang \
    clang-dev \
    fts-dev \ 
    git

RUN mkdir -p ${SRC_DIR} && \
    git clone --depth 1 --config advice.detachedHead=false --quiet \
    --branch ${GIT_BRANCH} \
    ${GIT_URL} \
    ${SRC_DIR}

RUN ${SRC_DIR}/make2/build_all.sh

RUN cp -r ${SRC_DIR}/jlibrary/addons ${J_OUTPUT_DIR}/ && \
    cp -r ${SRC_DIR}/jlibrary/bin ${J_OUTPUT_DIR}/ && \
    cp -r ${SRC_DIR}/jlibrary/system ${J_OUTPUT_DIR}/ && \
    cp -r ${SRC_DIR}/jlibrary/tools ${J_OUTPUT_DIR}/ && \
    cp ${SRC_DIR}/bin/linux/*/* ${J_OUTPUT_DIR}/bin/

FROM alpine:latest

ARG J_OUTPUT_DIR
ARG J_INSTALL_DIR

COPY --from=builder ${J_OUTPUT_DIR}/ ${J_INSTALL_DIR}

ENV PATH="${J_INSTALL_DIR}/bin:${PATH}"

CMD [ "jconsole" ]