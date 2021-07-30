FROM registry.access.redhat.com/ubi8/nodejs-14
WORKDIR /usr/src/app
USER root
# Copy entitlements
# COPY ./etc-pki-entitlement /etc/pki/entitlement
# Copy subscription manager configurations
# COPY ./rhsm-conf /etc/rhsm
# COPY ./rhsm-ca /etc/rhsm/ca
# Delete /etc/rhsm-host to use entitlements from the build container
# RUN rm /etc/rhsm-host && \
#     # Initialize /etc/yum.repos.d/redhat.repo
#     # See https://access.redhat.com/solutions/1443553
#     yum repolist --disablerepo=* && \
#     subscription-manager repos --enable cecc-rhel8.3-ppc64le-baseos && \
#     yum -y update && \
#     yum -y install numactl-devel && \
#     # Remove entitlements and Subscription Manager configs
#     rm -rf /etc/pki/entitlement && \
#     rm -rf /etc/rhsm
# RUN rm /etc/rhsm-host
# RUN yum repolist --disablerepo=*
# RUN subscription-manager repos --enable cecc-rhel8.3-ppc64le-baseos
RUN yum -y update
RUN yum -y install numactl-devel
# RUN rm -rf /etc/pki/entitlement
# RUN rm -rf /etc/rhsm
COPY . /usr/src/app
RUN npm install --unsafe-perm
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "start"]
EXPOSE 3001
