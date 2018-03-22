FROM centos:7
ENV BI=/home/bamboo-first
ENV BH=/home/bamboo-home
ENV JH=/usr/java
ENV BIP=${BI}/atlassian-bamboo-6.4.0/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
ENV BSS=/home/bamboo-first/atlassian-bamboo-6.4.0/bin/start-bamboo.sh
ENV BSTP=/home/bamboo-first/atlassian-bamboo-6.4.0/bin/stop-bamboo.sh
ENV JAVA_HOME=/usr/java/jre1.8.0_161
USER root
RUN mkdir $BI; \
mkdir $BH; \
mkdir $JH; \
yum install -y wget net-tools; \
cd $JH; \
wget -O jre-8u161-linux-x64.tar.gz http://javadl.oracle.com/webapps/download/AutoDL?BundleId=230532_2f38c3b165be4555a1fa6e98c45e0808; \
tar -xvf jre-8u161-linux-x64.tar.gz; \
rm -rf jre-8u161-linux-x64.tar.gz; \
cd $BI; \
wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-6.4.0.tar.gz; \
tar -xvf atlassian-bamboo-6.4.0.tar.gz; \
RL=`grep -n bamboo.home= ${BI}/atlassian-bamboo-6.4.0/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties | head -n1 | cut -d: -f1`; \
sed -i "${RL}i bamboo.home=${BH}" $BIP; \
cat $BIP && rm -rf $BI/atlassian-bamboo-6.4.0.tar.gz
EXPOSE 8085
CMD ["sh", "-c", "sh $BSS -fg"]