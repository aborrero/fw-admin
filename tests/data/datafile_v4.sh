#!/bin/bash
IPT=/sbin/iptables ##ignore##
VOID=255.255.255.255 ##ignore##
ICMP_TYPE=--icmp-type ##ignore##
P_ICMP=icmp ##ignore##
IF_BOND2=bond2 ##ignore##
IF_CLUSTER=eth8 ##ignore##
IF_INET=bond0 ##ignore##
IF_VLAN10=bond1.10 ##ignore##
IF_VLAN23=bond1.23 ##ignore##
IF_VLAN27=bond1.27 ##ignore##
IF_VLAN28=bond1.28 ##ignore##
IF_VLAN31=bond1.31 ##ignore##
IF_VLAN34=bond1.34 ##ignore##
IF_VLAN35=tun0 ##ignore##
IF_VLAN51=bond1.51 ##ignore##
IF_VLAN54=bond1.54 ##ignore##
IF_VLAN6=bond1.6 ##ignore##
IF_VLAN7=bond1.7 ##ignore##
IP_ESP_277=172.16.170.234 ##ignore##
NET_VLAN1=172.16.2.224/27 ##ignore##
NET_VLAN2=172.16.3.0/29 ##ignore##
NET_VLAN4=172.16.4.40/29 ##ignore##
NET_VLAN6=172.16.5.0/24 ##ignore##
NET_VLAN7=172.16.2.0/25 ##ignore##
NET_VLAN8=172.16.4.32/29 ##ignore##
NET_VLAN10=172.16.3.64/26 ##ignore##
NET_VLAN11=172.16.2.128/26 ##ignore##
NET_VLAN12=172.16.4.64/26 ##ignore##
NET_VLAN18=172.16.3.32/27 ##ignore##
NET_VLAN19=172.16.3.128/27 ##ignore##
NET_VLAN23=172.16.2.192/28 ##ignore##
NET_VLAN27=172.16.4.128/25 ##ignore##
NET_VLAN28=172.16.3.8/29 ##ignore##
NET_VLAN29=172.16.8.0/25 ##ignore##
NET_VLAN31=172.16.8.128/25 ##ignore##
NET_VLAN33=192.168.3.0/24 ##ignore##
NET_VLAN34=192.168.5.0/24 ##ignore##
NET_VLAN35=192.168.250.0/24 ##ignore##
NET_VLAN51=172.16.4.0/26 ##ignore##
NET_VLAN53=172.16.3.160/27 ##ignore##
NET_VLAN54=172.16.3.192/26 ##ignore##
NET_VLAN116=172.16.255.0/24 ##ignore##
NET_VLAN21=$VOID ##ignore##
NET_VLAN26=$VOID ##ignore##
NET_VLAN30=$VOID ##ignore##
NET_VLAN38=172.16.93.208/28 ##ignore##
NET_VLAN40=172.16.3.16/28 ##ignore##
v192_168_250_114=192.168.250.114 #192.168.250.114
v192_168_250_118=192.168.250.118 #192.168.250.118
v192_168_250_122=192.168.250.122 #192.168.250.122
v192_168_250_126=192.168.250.126 #192.168.250.126
v192_168_250_130=192.168.250.130 #192.168.250.130
A92_123_6_34_DEPLOY_AKAMAITECHNOLOGIES_COM=92.123.6.34 #a92-123-6-34.deploy.akamaitechnologies.com
ADMIN_FEDORAPROJECT_ORG=admin.fedoraproject.org #admin.fedoraproject.org
APT_SW_BE=193.1.193.67 #apt.sw.be
ARCHIVE_SYNCPROXY_UBUNTU_COM=91.189.92.172 #archive.syncproxy.ubuntu.com
BARISTA_BESTPRACTICAL_COM=136.248.126.166 #barista.bestpractical.com
BLASTWAVE_NETWORK_COM=204.152.191.106 #blastwave.network.com
C301_CLOUDMARK_COM=208.83.137.114 #c301.cloudmark.com
C302_CLOUDMARK_COM=208.83.137.115 #c302.cloudmark.com
C303_CLOUDMARK_COM=208.83.139.204 #c303.cloudmark.com
CARROLL_ASET_PSU_EDU=128.118.2.96 #carroll.aset.psu.edu
CENTOS_CICT_FR=195.220.53.232 #centos.cict.fr
CENTOS_COPAHOST_COM=93.104.215.56 #centos.copahost.com
CISNE_SIM_UCM_ES=147.96.1.236 #cisne.sim.ucm.es
CLAMAV_N2000_NET=80.80.88.40 #clamav.n2000.net
CLOUD_GITHUB_COM=cloud.github.com #cloud.github.com
CNS_SERVICES_TMP_SUN_COM=192.18.110.17 #cns-services-tmp.sun.com
CONTENT_SATELLITE_RHN_REDHAT_COM=88.221.236.217 #content-satellite.rhn.redhat.com
CONTENT_WEB_RHN_REDHAT_COM=92.122.234.169 #content-web.rhn.redhat.com
CONTENT_XMLRPC_RHN_REDHAT_COM=88.221.236.218 #content-xmlrpc.rhn.redhat.com
DARYL_DOSTECH_CA=71.164.246.108 #daryl.dostech.ca
DB_AC_CLAMAV_NET=db.ac.clamav.net #db.ac.clamav.net
DB_LOCAL_CLAMAV_NET=db.local.clamav.net #db.local.clamav.net
DISCOVERY_RAZOR_CLOUDMARK_COM=discovery.razor.cloudmark.com #discovery.razor.cloudmark.com
DL_DROPBOX_COM=dl.dropbox.com #dl.dropbox.com
DOWNLOAD_FEDORA_PROJECT_ORG=206.188.192.100 #download.fedora.project.org
DOWNLOAD_FEDORAPROJECT_ORG=download.fedoraproject.org #download.fedoraproject.org
vfe00_123_123__dead_beef=$VOID #fe00:123:123::dead:beef
FTP_DEBIAN_ORG=130.89.148.12 #ftp.debian.org
FTP_DE_DEBIAN_ORG=141.76.2.4 #ftp.de.debian.org
FTP_FREE_FR=212.27.60.27 #ftp.free.fr
FTP_INTERNIC_NET=192.0.32.9 #ftp.internic.net
FTP_PRAMBERGER_AT=188.40.36.134 #ftp.pramberger.at
FTP_REDHAT_COM=209.132.183.61 #ftp.redhat.com
FTP_REDIRIS_ES=130.206.1.5 #ftp.rediris.es
FTP_SENDMAIL_ORG=209.246.26.16 #ftp.sendmail.org
FTP_TUX_ORG=207.172.156.132 #ftp.tux.org
FTP_XFREE86_ORG=204.152.184.78 #ftp.xfree86.org
FTP_X_ORG=18.7.25.161 #ftp.x.org
GERMANIUM_CANONICAL_COM=91.189.90.217 #germanium.canonical.com
GFORGE_FORJA_REDIRIS_ES=150.214.3.12 #gforge.forja.rediris.es
GITHUB_COM=207.97.227.239 #github.com
GOOGLE_PUBLIC_DNS_A_GOOGLE_COM=8.8.8.8 #google-public-dns-a.google.com
GOOGLE_PUBLIC_DNS_B_GOOGLE_COM=8.8.4.4 #google-public-dns-b.google.com
GTM_PANDASOFTWARE_AKADNS_NET=193.104.218.160 #gtm.pandasoftware.akadns.net
INV_CS_TMP_SUN_COM=192.18.110.18 #inv-cs-tmp.sun.com
MAILRELAY_33_WEBSITE_WS=64.70.19.170 #mailrelay.33.website.ws
N001_CLOUDMARK_COM=208.83.136.17 #n001.cloudmark.com
N002_CLOUDMARK_COM=208.83.136.18 #n002.cloudmark.com
N003_CLOUDMARK_COM=208.83.136.19 #n003.cloudmark.com
N004_CLOUDMARK_COM=208.83.136.20 #n004.cloudmark.com
V192_168_0_1=192.168.0.1 #192.168.0.1
V2A00_9AC0_C1CA__1=$VOID #2a00:9ac0:c1ca::1
WWW_GOOGLE_COM=www.google.com #www.google.com
ASDASD=$VOID ##ignore##
V10_0_0_1=10.0.0.1 #10.0.0.1
FE00__1=$VOID #fe00::1
V10_0_0_2=10.0.0.2 #10.0.0.2
FE00__2=$VOID #fe00::2
V10_0_0_3=10.0.0.3 #10.0.0.3
FE00__3=$VOID #fe00::3
V10_0_0_4=10.0.0.4 #10.0.0.4
FE00__4=$VOID #fe00::4
V10_0_0_5=10.0.0.5 #10.0.0.5
FE00__5=$VOID #fe00::5
V10_0_0_6=10.0.0.6 #10.0.0.6
FE00__6=$VOID #fe00::6
V10_0_0_7=10.0.0.7 #10.0.0.7
FE00__7=$VOID #fe00::7
V10_0_0_8=10.0.0.8 #10.0.0.8
FE00__8=$VOID #fe00::8
V10_0_0_9=10.0.0.9 #10.0.0.9
FE00__9=$VOID #fe00::9
V10_0_0_10=10.0.0.10 #10.0.0.10
FE00__10=$VOID #fe00::10
V10_0_0_11=10.0.0.11 #10.0.0.11
FE00__11=$VOID #fe00::11
V10_0_0_12=10.0.0.12 #10.0.0.12
FE00__12=$VOID #fe00::12
V10_0_0_13=10.0.0.13 #10.0.0.13
FE00__13=$VOID #fe00::13
V10_0_0_14=10.0.0.14 #10.0.0.14
FE00__14=$VOID #fe00::14
V10_0_0_15=10.0.0.15 #10.0.0.15
FE00__15=$VOID #fe00::15
V10_0_0_16=10.0.0.16 #10.0.0.16
FE00__16=$VOID #fe00::16
V10_0_0_17=10.0.0.17 #10.0.0.17
FE00__17=$VOID #fe00::17
V10_0_0_18=10.0.0.18 #10.0.0.18
FE00__18=$VOID #fe00::18
V10_0_0_19=10.0.0.19 #10.0.0.19
FE00__19=$VOID #fe00::19
V10_0_0_20=10.0.0.20 #10.0.0.20
FE00__20=$VOID #fe00::20
V10_0_0_21=10.0.0.21 #10.0.0.21
FE00__21=$VOID #fe00::21
V10_0_0_22=10.0.0.22 #10.0.0.22
FE00__22=$VOID #fe00::22
V10_0_0_23=10.0.0.23 #10.0.0.23
FE00__23=$VOID #fe00::23
V10_0_0_24=10.0.0.24 #10.0.0.24
FE00__24=$VOID #fe00::24
V10_0_0_25=10.0.0.25 #10.0.0.25
FE00__25=$VOID #fe00::25
V10_0_0_26=10.0.0.26 #10.0.0.26
FE00__26=$VOID #fe00::26
V10_0_0_27=10.0.0.27 #10.0.0.27
FE00__27=$VOID #fe00::27
V10_0_0_28=10.0.0.28 #10.0.0.28
FE00__28=$VOID #fe00::28
V10_0_0_29=10.0.0.29 #10.0.0.29
FE00__29=$VOID #fe00::29
V10_0_0_30=10.0.0.30 #10.0.0.30
FE00__30=$VOID #fe00::30
V10_0_0_31=10.0.0.31 #10.0.0.31
FE00__31=$VOID #fe00::31
V10_0_0_32=10.0.0.32 #10.0.0.32
FE00__32=$VOID #fe00::32
V10_0_0_33=10.0.0.33 #10.0.0.33
FE00__33=$VOID #fe00::33
V10_0_0_34=10.0.0.34 #10.0.0.34
FE00__34=$VOID #fe00::34
V10_0_0_35=10.0.0.35 #10.0.0.35
FE00__35=$VOID #fe00::35
V10_0_0_36=10.0.0.36 #10.0.0.36
FE00__36=$VOID #fe00::36
V10_0_0_37=10.0.0.37 #10.0.0.37
FE00__37=$VOID #fe00::37
V10_0_0_38=10.0.0.38 #10.0.0.38
FE00__38=$VOID #fe00::38
V10_0_0_39=10.0.0.39 #10.0.0.39
FE00__39=$VOID #fe00::39
V10_0_0_40=10.0.0.40 #10.0.0.40
FE00__40=$VOID #fe00::40
V10_0_0_41=10.0.0.41 #10.0.0.41
FE00__41=$VOID #fe00::41
V10_0_0_42=10.0.0.42 #10.0.0.42
FE00__42=$VOID #fe00::42
V10_0_0_43=10.0.0.43 #10.0.0.43
FE00__43=$VOID #fe00::43
V10_0_0_44=10.0.0.44 #10.0.0.44
FE00__44=$VOID #fe00::44
V10_0_0_45=10.0.0.45 #10.0.0.45
FE00__45=$VOID #fe00::45
V10_0_0_46=10.0.0.46 #10.0.0.46
FE00__46=$VOID #fe00::46
V10_0_0_47=10.0.0.47 #10.0.0.47
FE00__47=$VOID #fe00::47
V10_0_0_48=10.0.0.48 #10.0.0.48
FE00__48=$VOID #fe00::48
V10_0_0_49=10.0.0.49 #10.0.0.49
FE00__49=$VOID #fe00::49
V10_0_0_50=10.0.0.50 #10.0.0.50
FE00__50=$VOID #fe00::50
V10_0_0_51=10.0.0.51 #10.0.0.51
FE00__51=$VOID #fe00::51
V10_0_0_52=10.0.0.52 #10.0.0.52
FE00__52=$VOID #fe00::52
V10_0_0_53=10.0.0.53 #10.0.0.53
FE00__53=$VOID #fe00::53
V10_0_0_54=10.0.0.54 #10.0.0.54
FE00__54=$VOID #fe00::54
V10_0_0_55=10.0.0.55 #10.0.0.55
FE00__55=$VOID #fe00::55
V10_0_0_56=10.0.0.56 #10.0.0.56
FE00__56=$VOID #fe00::56
V10_0_0_57=10.0.0.57 #10.0.0.57
FE00__57=$VOID #fe00::57
V10_0_0_58=10.0.0.58 #10.0.0.58
FE00__58=$VOID #fe00::58
V10_0_0_59=10.0.0.59 #10.0.0.59
FE00__59=$VOID #fe00::59
V10_0_0_60=10.0.0.60 #10.0.0.60
FE00__60=$VOID #fe00::60
V10_0_0_61=10.0.0.61 #10.0.0.61
FE00__61=$VOID #fe00::61
V10_0_0_62=10.0.0.62 #10.0.0.62
FE00__62=$VOID #fe00::62
V10_0_0_63=10.0.0.63 #10.0.0.63
FE00__63=$VOID #fe00::63
V10_0_0_64=10.0.0.64 #10.0.0.64
FE00__64=$VOID #fe00::64
V10_0_0_65=10.0.0.65 #10.0.0.65
FE00__65=$VOID #fe00::65
V10_0_0_66=10.0.0.66 #10.0.0.66
FE00__66=$VOID #fe00::66
V10_0_0_67=10.0.0.67 #10.0.0.67
FE00__67=$VOID #fe00::67
V10_0_0_68=10.0.0.68 #10.0.0.68
FE00__68=$VOID #fe00::68
V10_0_0_69=10.0.0.69 #10.0.0.69
FE00__69=$VOID #fe00::69
V10_0_0_70=10.0.0.70 #10.0.0.70
FE00__70=$VOID #fe00::70
V10_0_0_71=10.0.0.71 #10.0.0.71
FE00__71=$VOID #fe00::71
V10_0_0_72=10.0.0.72 #10.0.0.72
FE00__72=$VOID #fe00::72
V10_0_0_73=10.0.0.73 #10.0.0.73
FE00__73=$VOID #fe00::73
V10_0_0_74=10.0.0.74 #10.0.0.74
FE00__74=$VOID #fe00::74
V10_0_0_75=10.0.0.75 #10.0.0.75
FE00__75=$VOID #fe00::75
V10_0_0_76=10.0.0.76 #10.0.0.76
FE00__76=$VOID #fe00::76
V10_0_0_77=10.0.0.77 #10.0.0.77
FE00__77=$VOID #fe00::77
V10_0_0_78=10.0.0.78 #10.0.0.78
FE00__78=$VOID #fe00::78
V10_0_0_79=10.0.0.79 #10.0.0.79
FE00__79=$VOID #fe00::79
V10_0_0_80=10.0.0.80 #10.0.0.80
FE00__80=$VOID #fe00::80
V10_0_0_81=10.0.0.81 #10.0.0.81
FE00__81=$VOID #fe00::81
V10_0_0_82=10.0.0.82 #10.0.0.82
FE00__82=$VOID #fe00::82
V10_0_0_83=10.0.0.83 #10.0.0.83
FE00__83=$VOID #fe00::83
V10_0_0_84=10.0.0.84 #10.0.0.84
FE00__84=$VOID #fe00::84
V10_0_0_85=10.0.0.85 #10.0.0.85
FE00__85=$VOID #fe00::85
V10_0_0_86=10.0.0.86 #10.0.0.86
FE00__86=$VOID #fe00::86
V10_0_0_87=10.0.0.87 #10.0.0.87
FE00__87=$VOID #fe00::87
V10_0_0_88=10.0.0.88 #10.0.0.88
FE00__88=$VOID #fe00::88
V10_0_0_89=10.0.0.89 #10.0.0.89
FE00__89=$VOID #fe00::89
V10_0_0_90=10.0.0.90 #10.0.0.90
FE00__90=$VOID #fe00::90
V10_0_0_91=10.0.0.91 #10.0.0.91
FE00__91=$VOID #fe00::91
V10_0_0_92=10.0.0.92 #10.0.0.92
FE00__92=$VOID #fe00::92
V10_0_0_93=10.0.0.93 #10.0.0.93
FE00__93=$VOID #fe00::93
V10_0_0_94=10.0.0.94 #10.0.0.94
FE00__94=$VOID #fe00::94
V10_0_0_95=10.0.0.95 #10.0.0.95
FE00__95=$VOID #fe00::95
V10_0_0_96=10.0.0.96 #10.0.0.96
FE00__96=$VOID #fe00::96
V10_0_0_97=10.0.0.97 #10.0.0.97
FE00__97=$VOID #fe00::97
V10_0_0_98=10.0.0.98 #10.0.0.98
FE00__98=$VOID #fe00::98
V10_0_0_99=10.0.0.99 #10.0.0.99
FE00__99=$VOID #fe00::99
V10_0_0_100=10.0.0.100 #10.0.0.100
FE00__100=$VOID #fe00::100
V10_0_0_101=10.0.0.101 #10.0.0.101
FE00__101=$VOID #fe00::101
V10_0_0_102=10.0.0.102 #10.0.0.102
FE00__102=$VOID #fe00::102
V10_0_0_103=10.0.0.103 #10.0.0.103
FE00__103=$VOID #fe00::103
V10_0_0_104=10.0.0.104 #10.0.0.104
FE00__104=$VOID #fe00::104
V10_0_0_105=10.0.0.105 #10.0.0.105
FE00__105=$VOID #fe00::105
V10_0_0_106=10.0.0.106 #10.0.0.106
FE00__106=$VOID #fe00::106
V10_0_0_107=10.0.0.107 #10.0.0.107
FE00__107=$VOID #fe00::107
V10_0_0_108=10.0.0.108 #10.0.0.108
FE00__108=$VOID #fe00::108
V10_0_0_109=10.0.0.109 #10.0.0.109
FE00__109=$VOID #fe00::109
V10_0_0_110=10.0.0.110 #10.0.0.110
FE00__110=$VOID #fe00::110
V10_0_0_111=10.0.0.111 #10.0.0.111
FE00__111=$VOID #fe00::111
V10_0_0_112=10.0.0.112 #10.0.0.112
FE00__112=$VOID #fe00::112
V10_0_0_113=10.0.0.113 #10.0.0.113
FE00__113=$VOID #fe00::113
V10_0_0_114=10.0.0.114 #10.0.0.114
FE00__114=$VOID #fe00::114
V10_0_0_115=10.0.0.115 #10.0.0.115
FE00__115=$VOID #fe00::115
V10_0_0_116=10.0.0.116 #10.0.0.116
FE00__116=$VOID #fe00::116
V10_0_0_117=10.0.0.117 #10.0.0.117
FE00__117=$VOID #fe00::117
V10_0_0_118=10.0.0.118 #10.0.0.118
FE00__118=$VOID #fe00::118
V10_0_0_119=10.0.0.119 #10.0.0.119
FE00__119=$VOID #fe00::119
V10_0_0_120=10.0.0.120 #10.0.0.120
FE00__120=$VOID #fe00::120
V10_0_0_121=10.0.0.121 #10.0.0.121
FE00__121=$VOID #fe00::121
V10_0_0_122=10.0.0.122 #10.0.0.122
FE00__122=$VOID #fe00::122
V10_0_0_123=10.0.0.123 #10.0.0.123
FE00__123=$VOID #fe00::123
V10_0_0_124=10.0.0.124 #10.0.0.124
FE00__124=$VOID #fe00::124
V10_0_0_125=10.0.0.125 #10.0.0.125
FE00__125=$VOID #fe00::125
V10_0_0_126=10.0.0.126 #10.0.0.126
FE00__126=$VOID #fe00::126
V10_0_0_127=10.0.0.127 #10.0.0.127
FE00__127=$VOID #fe00::127
V10_0_0_128=10.0.0.128 #10.0.0.128
FE00__128=$VOID #fe00::128
V10_0_0_129=10.0.0.129 #10.0.0.129
FE00__129=$VOID #fe00::129
V10_0_0_130=10.0.0.130 #10.0.0.130
FE00__130=$VOID #fe00::130
V10_0_0_131=10.0.0.131 #10.0.0.131
FE00__131=$VOID #fe00::131
V10_0_0_132=10.0.0.132 #10.0.0.132
FE00__132=$VOID #fe00::132
V10_0_0_133=10.0.0.133 #10.0.0.133
FE00__133=$VOID #fe00::133
V10_0_0_134=10.0.0.134 #10.0.0.134
FE00__134=$VOID #fe00::134
V10_0_0_135=10.0.0.135 #10.0.0.135
FE00__135=$VOID #fe00::135
V10_0_0_136=10.0.0.136 #10.0.0.136
FE00__136=$VOID #fe00::136
V10_0_0_137=10.0.0.137 #10.0.0.137
FE00__137=$VOID #fe00::137
V10_0_0_138=10.0.0.138 #10.0.0.138
FE00__138=$VOID #fe00::138
V10_0_0_139=10.0.0.139 #10.0.0.139
FE00__139=$VOID #fe00::139
V10_0_0_140=10.0.0.140 #10.0.0.140
FE00__140=$VOID #fe00::140
V10_0_0_141=10.0.0.141 #10.0.0.141
FE00__141=$VOID #fe00::141
V10_0_0_142=10.0.0.142 #10.0.0.142
FE00__142=$VOID #fe00::142
V10_0_0_143=10.0.0.143 #10.0.0.143
FE00__143=$VOID #fe00::143
V10_0_0_144=10.0.0.144 #10.0.0.144
FE00__144=$VOID #fe00::144
V10_0_0_145=10.0.0.145 #10.0.0.145
FE00__145=$VOID #fe00::145
V10_0_0_146=10.0.0.146 #10.0.0.146
FE00__146=$VOID #fe00::146
V10_0_0_147=10.0.0.147 #10.0.0.147
FE00__147=$VOID #fe00::147
V10_0_0_148=10.0.0.148 #10.0.0.148
FE00__148=$VOID #fe00::148
V10_0_0_149=10.0.0.149 #10.0.0.149
FE00__149=$VOID #fe00::149
V10_0_0_150=10.0.0.150 #10.0.0.150
FE00__150=$VOID #fe00::150
V10_0_0_151=10.0.0.151 #10.0.0.151
FE00__151=$VOID #fe00::151
V10_0_0_152=10.0.0.152 #10.0.0.152
FE00__152=$VOID #fe00::152
V10_0_0_153=10.0.0.153 #10.0.0.153
FE00__153=$VOID #fe00::153
V10_0_0_154=10.0.0.154 #10.0.0.154
FE00__154=$VOID #fe00::154
V10_0_0_155=10.0.0.155 #10.0.0.155
FE00__155=$VOID #fe00::155
V10_0_0_156=10.0.0.156 #10.0.0.156
FE00__156=$VOID #fe00::156
V10_0_0_157=10.0.0.157 #10.0.0.157
FE00__157=$VOID #fe00::157
V10_0_0_158=10.0.0.158 #10.0.0.158
FE00__158=$VOID #fe00::158
V10_0_0_159=10.0.0.159 #10.0.0.159
FE00__159=$VOID #fe00::159
V10_0_0_160=10.0.0.160 #10.0.0.160
FE00__160=$VOID #fe00::160
V10_0_0_161=10.0.0.161 #10.0.0.161
FE00__161=$VOID #fe00::161
V10_0_0_162=10.0.0.162 #10.0.0.162
FE00__162=$VOID #fe00::162
V10_0_0_163=10.0.0.163 #10.0.0.163
FE00__163=$VOID #fe00::163
V10_0_0_164=10.0.0.164 #10.0.0.164
FE00__164=$VOID #fe00::164
V10_0_0_165=10.0.0.165 #10.0.0.165
FE00__165=$VOID #fe00::165
V10_0_0_166=10.0.0.166 #10.0.0.166
FE00__166=$VOID #fe00::166
V10_0_0_167=10.0.0.167 #10.0.0.167
FE00__167=$VOID #fe00::167
V10_0_0_168=10.0.0.168 #10.0.0.168
FE00__168=$VOID #fe00::168
V10_0_0_169=10.0.0.169 #10.0.0.169
FE00__169=$VOID #fe00::169
V10_0_0_170=10.0.0.170 #10.0.0.170
FE00__170=$VOID #fe00::170
V10_0_0_171=10.0.0.171 #10.0.0.171
FE00__171=$VOID #fe00::171
V10_0_0_172=10.0.0.172 #10.0.0.172
FE00__172=$VOID #fe00::172
V10_0_0_173=10.0.0.173 #10.0.0.173
FE00__173=$VOID #fe00::173
V10_0_0_174=10.0.0.174 #10.0.0.174
FE00__174=$VOID #fe00::174
V10_0_0_175=10.0.0.175 #10.0.0.175
FE00__175=$VOID #fe00::175
V10_0_0_176=10.0.0.176 #10.0.0.176
FE00__176=$VOID #fe00::176
V10_0_0_177=10.0.0.177 #10.0.0.177
FE00__177=$VOID #fe00::177
V10_0_0_178=10.0.0.178 #10.0.0.178
FE00__178=$VOID #fe00::178
V10_0_0_179=10.0.0.179 #10.0.0.179
FE00__179=$VOID #fe00::179
V10_0_0_180=10.0.0.180 #10.0.0.180
FE00__180=$VOID #fe00::180
V10_0_0_181=10.0.0.181 #10.0.0.181
FE00__181=$VOID #fe00::181
V10_0_0_182=10.0.0.182 #10.0.0.182
FE00__182=$VOID #fe00::182
V10_0_0_183=10.0.0.183 #10.0.0.183
FE00__183=$VOID #fe00::183
V10_0_0_184=10.0.0.184 #10.0.0.184
FE00__184=$VOID #fe00::184
V10_0_0_185=10.0.0.185 #10.0.0.185
FE00__185=$VOID #fe00::185
V10_0_0_186=10.0.0.186 #10.0.0.186
FE00__186=$VOID #fe00::186
V10_0_0_187=10.0.0.187 #10.0.0.187
FE00__187=$VOID #fe00::187
V10_0_0_188=10.0.0.188 #10.0.0.188
FE00__188=$VOID #fe00::188
V10_0_0_189=10.0.0.189 #10.0.0.189
FE00__189=$VOID #fe00::189
V10_0_0_190=10.0.0.190 #10.0.0.190
FE00__190=$VOID #fe00::190
V10_0_0_191=10.0.0.191 #10.0.0.191
FE00__191=$VOID #fe00::191
V10_0_0_192=10.0.0.192 #10.0.0.192
FE00__192=$VOID #fe00::192
V10_0_0_193=10.0.0.193 #10.0.0.193
FE00__193=$VOID #fe00::193
V10_0_0_194=10.0.0.194 #10.0.0.194
FE00__194=$VOID #fe00::194
V10_0_0_195=10.0.0.195 #10.0.0.195
FE00__195=$VOID #fe00::195
V10_0_0_196=10.0.0.196 #10.0.0.196
FE00__196=$VOID #fe00::196
V10_0_0_197=10.0.0.197 #10.0.0.197
FE00__197=$VOID #fe00::197
V10_0_0_198=10.0.0.198 #10.0.0.198
FE00__198=$VOID #fe00::198
V10_0_0_199=10.0.0.199 #10.0.0.199
FE00__199=$VOID #fe00::199
V10_0_0_200=10.0.0.200 #10.0.0.200
FE00__200=$VOID #fe00::200
V10_0_0_201=10.0.0.201 #10.0.0.201
FE00__201=$VOID #fe00::201
V10_0_0_202=10.0.0.202 #10.0.0.202
FE00__202=$VOID #fe00::202
V10_0_0_203=10.0.0.203 #10.0.0.203
FE00__203=$VOID #fe00::203
V10_0_0_204=10.0.0.204 #10.0.0.204
FE00__204=$VOID #fe00::204
V10_0_0_205=10.0.0.205 #10.0.0.205
FE00__205=$VOID #fe00::205
V10_0_0_206=10.0.0.206 #10.0.0.206
FE00__206=$VOID #fe00::206
V10_0_0_207=10.0.0.207 #10.0.0.207
FE00__207=$VOID #fe00::207
V10_0_0_208=10.0.0.208 #10.0.0.208
FE00__208=$VOID #fe00::208
V10_0_0_209=10.0.0.209 #10.0.0.209
FE00__209=$VOID #fe00::209
V10_0_0_210=10.0.0.210 #10.0.0.210
FE00__210=$VOID #fe00::210
V10_0_0_211=10.0.0.211 #10.0.0.211
FE00__211=$VOID #fe00::211
V10_0_0_212=10.0.0.212 #10.0.0.212
FE00__212=$VOID #fe00::212
V10_0_0_213=10.0.0.213 #10.0.0.213
FE00__213=$VOID #fe00::213
V10_0_0_214=10.0.0.214 #10.0.0.214
FE00__214=$VOID #fe00::214
V10_0_0_215=10.0.0.215 #10.0.0.215
FE00__215=$VOID #fe00::215
V10_0_0_216=10.0.0.216 #10.0.0.216
FE00__216=$VOID #fe00::216
V10_0_0_217=10.0.0.217 #10.0.0.217
FE00__217=$VOID #fe00::217
V10_0_0_218=10.0.0.218 #10.0.0.218
FE00__218=$VOID #fe00::218
V10_0_0_219=10.0.0.219 #10.0.0.219
FE00__219=$VOID #fe00::219
V10_0_0_220=10.0.0.220 #10.0.0.220
FE00__220=$VOID #fe00::220
V10_0_0_221=10.0.0.221 #10.0.0.221
FE00__221=$VOID #fe00::221
V10_0_0_222=10.0.0.222 #10.0.0.222
FE00__222=$VOID #fe00::222
V10_0_0_223=10.0.0.223 #10.0.0.223
FE00__223=$VOID #fe00::223
V10_0_0_224=10.0.0.224 #10.0.0.224
FE00__224=$VOID #fe00::224
V10_0_0_225=10.0.0.225 #10.0.0.225
FE00__225=$VOID #fe00::225
V10_0_0_226=10.0.0.226 #10.0.0.226
FE00__226=$VOID #fe00::226
V10_0_0_227=10.0.0.227 #10.0.0.227
FE00__227=$VOID #fe00::227
V10_0_0_228=10.0.0.228 #10.0.0.228
FE00__228=$VOID #fe00::228
V10_0_0_229=10.0.0.229 #10.0.0.229
FE00__229=$VOID #fe00::229
V10_0_0_230=10.0.0.230 #10.0.0.230
FE00__230=$VOID #fe00::230
V10_0_0_231=10.0.0.231 #10.0.0.231
FE00__231=$VOID #fe00::231
V10_0_0_232=10.0.0.232 #10.0.0.232
FE00__232=$VOID #fe00::232
V10_0_0_233=10.0.0.233 #10.0.0.233
FE00__233=$VOID #fe00::233
V10_0_0_234=10.0.0.234 #10.0.0.234
FE00__234=$VOID #fe00::234
V10_0_0_235=10.0.0.235 #10.0.0.235
FE00__235=$VOID #fe00::235
V10_0_0_236=10.0.0.236 #10.0.0.236
FE00__236=$VOID #fe00::236
V10_0_0_237=10.0.0.237 #10.0.0.237
FE00__237=$VOID #fe00::237
V10_0_0_238=10.0.0.238 #10.0.0.238
FE00__238=$VOID #fe00::238
V10_0_0_239=10.0.0.239 #10.0.0.239
FE00__239=$VOID #fe00::239
V10_0_0_240=10.0.0.240 #10.0.0.240
FE00__240=$VOID #fe00::240
V10_0_0_241=10.0.0.241 #10.0.0.241
FE00__241=$VOID #fe00::241
V10_0_0_242=10.0.0.242 #10.0.0.242
FE00__242=$VOID #fe00::242
V10_0_0_243=10.0.0.243 #10.0.0.243
FE00__243=$VOID #fe00::243
V10_0_0_244=10.0.0.244 #10.0.0.244
FE00__244=$VOID #fe00::244
V10_0_0_245=10.0.0.245 #10.0.0.245
FE00__245=$VOID #fe00::245
V10_0_0_246=10.0.0.246 #10.0.0.246
FE00__246=$VOID #fe00::246
V10_0_0_247=10.0.0.247 #10.0.0.247
FE00__247=$VOID #fe00::247
V10_0_0_248=10.0.0.248 #10.0.0.248
FE00__248=$VOID #fe00::248
V10_0_0_249=10.0.0.249 #10.0.0.249
FE00__249=$VOID #fe00::249
V10_0_0_250=10.0.0.250 #10.0.0.250
FE00__250=$VOID #fe00::250
V10_0_0_251=10.0.0.251 #10.0.0.251
FE00__251=$VOID #fe00::251
V10_0_0_252=10.0.0.252 #10.0.0.252
FE00__252=$VOID #fe00::252
V10_0_0_253=10.0.0.253 #10.0.0.253
FE00__253=$VOID #fe00::253
V10_0_0_254=10.0.0.254 #10.0.0.254
FE00__254=$VOID #fe00::254
IPSET=/usr/sbin/ipset ##ignore##
INET=inet ##ignore##
S_LDAP=s_ldap_ipv4 ##ignore##
S_RADIUS=s_radius_ipv4 ##ignore##
REP_RHEL=rep_rhel_ipv4 ##ignore##
S_DNS=s_dns_ipv4 ##ignore##
REPOS=repos_ipv4 ##ignore##
