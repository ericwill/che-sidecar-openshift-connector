# Copyright (c) 2020 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation

FROM quay.io/eclipse/che-container-tools:1.0.0-36dcd2a

# odo and oc versions have to match the ones defined in https://github.com/redhat-developer/vscode-openshift-tools/blob/master/src/tools.json
ENV ODO_VERSION=v1.2.1 \
    OC_VERSION=4.3.3

# plugin executes the commands relying on Bash
RUN dnf install -y bash && \
    # install oc
    wget -O- https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.3.3/openshift-client-linux-${OC_VERSION}.tar.gz | tar xvz oc -C /usr/local/bin && \
    #Set the arch
    export ARCH="$(uname -m)" && if [[ ${ARCH} == "x86_64" ]]; then export ARCH="amd64"; fi && \
    # install odo
    wget -O /usr/local/bin/odo https://mirror.openshift.com/pub/openshift-v4/clients/odo/${ODO_VERSION}/odo-linux-${ARCH} && \
    chmod +x /usr/local/bin/odo