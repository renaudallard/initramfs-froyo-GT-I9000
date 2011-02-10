#! /system/bin/sh

POLICY_DIR='/data/ccs'
PROFILE=0

file_exists() {
	cat $1 > /dev/null 2>&1
}

if cd $POLICY_DIR 2> /dev/null
then
	: # do nothing
else
	echo "Creating $POLICY_DIR/ dir"
	mkdir $POLICY_DIR	

	#chown command is not available
	#chown root:root $POLICY_DIR

	if cd $POLICY_DIR 2> /dev/null 
	then 
		: # do nothing
	else
		echo "Can't make dir $POLICY_DIR"
		exit 1
	fi
fi

chmod 0700 $POLICY_DIR

PROFILE_TYPE='--file-network-profile'

#while [ $# -gt 0 ]
#do
#	case "$1" in
#	--file-only-profile|--file-network-profile|--full-profile)
#		PROFILE_TYPE="$1"
#		;;
#	esac
#	shift
#done
#cd $POLICY_DIR

#Creating PROFILES 
if file_exists profile.conf
then
	echo "profile.conf already existing. Profile won't be initialized"
else
	echo "Creating profile"
	case "$PROFILE_TYPE" in

		-file-only-profile)

			#(MAC for FILES only)
			cat > profile.conf <<- EOF
				0-COMMENT=-----Disabled Mode-----
				0-MAC_FOR_FILE=disabled
				0-TOMOYO_VERBOSE=disabled
				1-COMMENT=-----Learning Mode-----
				1-MAC_FOR_FILE=learning
				1-TOMOYO_VERBOSE=disabled
				2-COMMENT=-----Permissive Mode-----
				2-MAC_FOR_FILE=permissive
				2-TOMOYO_VERBOSE=enabled
				3-COMMENT=-----Enforcing Mode-----
				3-MAC_FOR_FILE=enforcing
				3-TOMOYO_VERBOSE=enabled
			EOF
		;;
		
		--file-network-profile)
		#(MAC for FILES + NETWORK)
		cat > profile.conf <<- EOF
			0-COMMENT=-----Disabled Mode-----
			0-MAC_FOR_FILE=disabled
			0-MAC_FOR_NETWORK=disabled
			0-TOMOYO_VERBOSE=disabled
			1-COMMENT=-----Learning Mode-----
			1-MAC_FOR_FILE=learning
			1-MAC_FOR_NETWORK=learning
			1-TOMOYO_VERBOSE=disabled
			2-COMMENT=-----Permissive Mode-----
			2-MAC_FOR_FILE=permissive
			2-MAC_FOR_NETWORK=permissive
			2-TOMOYO_VERBOSE=enabled
			3-COMMENT=-----Enforcing Mode-----
			3-MAC_FOR_FILE=enforcing
			3-MAC_FOR_NETWORK=enforcing
			3-TOMOYO_VERBOSE=enabled
		EOF
		;;

		*)
		# full profiles
		cat > profile.conf <<- EOF
			0-COMMENT=-----Disabled Mode-----
			0-MAC_FOR_FILE=disabled
			0-MAC_FOR_IOCTL=disabled
			0-MAC_FOR_ARGV0=disabled
			0-MAC_FOR_ENV=disabled
			0-MAC_FOR_NETWORK=disabled
			0-MAC_FOR_SIGNAL=disabled
			0-DENY_CONCEAL_MOUNT=disabled
			0-RESTRICT_CHROOT=disabled
			0-RESTRICT_MOUNT=disabled
			0-RESTRICT_UNMOUNT=disabled
			0-RESTRICT_PIVOT_ROOT=disabled
			0-RESTRICT_AUTOBIND=disabled
			0-MAX_ACCEPT_ENTRY=2048
			0-MAX_GRANT_LOG=1024
			0-MAX_REJECT_LOG=1024
			0-TOMOYO_VERBOSE=enabled
			0-SLEEP_PERIOD=0
			0-MAC_FOR_CAPABILITY::inet_tcp_create=disabled
			0-MAC_FOR_CAPABILITY::inet_tcp_listen=disabled
			0-MAC_FOR_CAPABILITY::inet_tcp_connect=disabled
			0-MAC_FOR_CAPABILITY::use_inet_udp=disabled
			0-MAC_FOR_CAPABILITY::use_inet_ip=disabled
			0-MAC_FOR_CAPABILITY::use_route=disabled
			0-MAC_FOR_CAPABILITY::use_packet=disabled
			0-MAC_FOR_CAPABILITY::SYS_MOUNT=disabled
			0-MAC_FOR_CAPABILITY::SYS_UMOUNT=disabled
			0-MAC_FOR_CAPABILITY::SYS_REBOOT=disabled
			0-MAC_FOR_CAPABILITY::SYS_CHROOT=disabled
			0-MAC_FOR_CAPABILITY::SYS_KILL=disabled
			0-MAC_FOR_CAPABILITY::SYS_VHANGUP=disabled
			0-MAC_FOR_CAPABILITY::SYS_TIME=disabled
			0-MAC_FOR_CAPABILITY::SYS_NICE=disabled
			0-MAC_FOR_CAPABILITY::SYS_SETHOSTNAME=disabled
			0-MAC_FOR_CAPABILITY::use_kernel_module=disabled
			0-MAC_FOR_CAPABILITY::create_fifo=disabled
			0-MAC_FOR_CAPABILITY::create_block_dev=disabled
			0-MAC_FOR_CAPABILITY::create_char_dev=disabled
			0-MAC_FOR_CAPABILITY::create_unix_socket=disabled
			0-MAC_FOR_CAPABILITY::SYS_LINK=disabled
			0-MAC_FOR_CAPABILITY::SYS_SYMLINK=disabled
			0-MAC_FOR_CAPABILITY::SYS_RENAME=disabled
			0-MAC_FOR_CAPABILITY::SYS_UNLINK=disabled
			0-MAC_FOR_CAPABILITY::SYS_CHMOD=disabled
			0-MAC_FOR_CAPABILITY::SYS_CHOWN=disabled
			0-MAC_FOR_CAPABILITY::SYS_IOCTL=disabled
			0-MAC_FOR_CAPABILITY::SYS_KEXEC_LOAD=disabled
			0-MAC_FOR_CAPABILITY::SYS_PIVOT_ROOT=disabled
			0-MAC_FOR_CAPABILITY::SYS_PTRACE=disabled
			1-COMMENT=-----Learning Mode-----
			1-MAC_FOR_FILE=learning
			1-MAC_FOR_IOCTL=learning
			1-MAC_FOR_ARGV0=learning
			1-MAC_FOR_ENV=learning
			1-MAC_FOR_NETWORK=learning
			1-MAC_FOR_SIGNAL=learning
			1-DENY_CONCEAL_MOUNT=permissive
			1-RESTRICT_CHROOT=learning
			1-RESTRICT_MOUNT=learning
			1-RESTRICT_UNMOUNT=permissive
			1-RESTRICT_PIVOT_ROOT=learning
			1-RESTRICT_AUTOBIND=enabled
			1-MAX_ACCEPT_ENTRY=2048
			1-MAX_GRANT_LOG=1024
			1-MAX_REJECT_LOG=1024
			1-TOMOYO_VERBOSE=disabled
			1-SLEEP_PERIOD=0
			1-MAC_FOR_CAPABILITY::inet_tcp_create=learning
			1-MAC_FOR_CAPABILITY::inet_tcp_listen=learning
			1-MAC_FOR_CAPABILITY::inet_tcp_connect=learning
			1-MAC_FOR_CAPABILITY::use_inet_udp=learning
			1-MAC_FOR_CAPABILITY::use_inet_ip=learning
			1-MAC_FOR_CAPABILITY::use_route=learning
			1-MAC_FOR_CAPABILITY::use_packet=learning
			1-MAC_FOR_CAPABILITY::SYS_MOUNT=learning
			1-MAC_FOR_CAPABILITY::SYS_UMOUNT=learning
			1-MAC_FOR_CAPABILITY::SYS_REBOOT=learning
			1-MAC_FOR_CAPABILITY::SYS_CHROOT=learning
			1-MAC_FOR_CAPABILITY::SYS_KILL=learning
			1-MAC_FOR_CAPABILITY::SYS_VHANGUP=learning
			1-MAC_FOR_CAPABILITY::SYS_TIME=learning
			1-MAC_FOR_CAPABILITY::SYS_NICE=learning
			1-MAC_FOR_CAPABILITY::SYS_SETHOSTNAME=learning
			1-MAC_FOR_CAPABILITY::use_kernel_module=learning
			1-MAC_FOR_CAPABILITY::create_fifo=learning
			1-MAC_FOR_CAPABILITY::create_block_dev=learning
			1-MAC_FOR_CAPABILITY::create_char_dev=learning
			1-MAC_FOR_CAPABILITY::create_unix_socket=learning
			1-MAC_FOR_CAPABILITY::SYS_LINK=learning
			1-MAC_FOR_CAPABILITY::SYS_SYMLINK=learning
			1-MAC_FOR_CAPABILITY::SYS_RENAME=learning
			1-MAC_FOR_CAPABILITY::SYS_UNLINK=learning
			1-MAC_FOR_CAPABILITY::SYS_CHMOD=learning
			1-MAC_FOR_CAPABILITY::SYS_CHOWN=learning
			1-MAC_FOR_CAPABILITY::SYS_IOCTL=learning
			1-MAC_FOR_CAPABILITY::SYS_KEXEC_LOAD=learning
			1-MAC_FOR_CAPABILITY::SYS_PIVOT_ROOT=learning
			1-MAC_FOR_CAPABILITY::SYS_PTRACE=learning
			2-COMMENT=-----Permissive Mode-----
			2-MAC_FOR_FILE=permissive
			2-MAC_FOR_IOCTL=permissive
			2-MAC_FOR_ARGV0=permissive
			2-MAC_FOR_ENV=permissive
			2-MAC_FOR_NETWORK=permissive
			2-MAC_FOR_SIGNAL=permissive
			2-DENY_CONCEAL_MOUNT=permissive
			2-RESTRICT_CHROOT=permissive
			2-RESTRICT_MOUNT=permissive
			2-RESTRICT_UNMOUNT=permissive
			2-RESTRICT_PIVOT_ROOT=permissive
			2-RESTRICT_AUTOBIND=enabled
			2-MAX_ACCEPT_ENTRY=2048
			2-MAX_GRANT_LOG=1024
			2-MAX_REJECT_LOG=1024
			2-TOMOYO_VERBOSE=enabled
			2-SLEEP_PERIOD=0
			2-MAC_FOR_CAPABILITY::inet_tcp_create=permissive
			2-MAC_FOR_CAPABILITY::inet_tcp_listen=permissive
			2-MAC_FOR_CAPABILITY::inet_tcp_connect=permissive
			2-MAC_FOR_CAPABILITY::use_inet_udp=permissive
			2-MAC_FOR_CAPABILITY::use_inet_ip=permissive
			2-MAC_FOR_CAPABILITY::use_route=permissive
			2-MAC_FOR_CAPABILITY::use_packet=permissive
			2-MAC_FOR_CAPABILITY::SYS_MOUNT=permissive
			2-MAC_FOR_CAPABILITY::SYS_UMOUNT=permissive
			2-MAC_FOR_CAPABILITY::SYS_REBOOT=permissive
			2-MAC_FOR_CAPABILITY::SYS_CHROOT=permissive
			2-MAC_FOR_CAPABILITY::SYS_KILL=permissive
			2-MAC_FOR_CAPABILITY::SYS_VHANGUP=permissive
			2-MAC_FOR_CAPABILITY::SYS_TIME=permissive
			2-MAC_FOR_CAPABILITY::SYS_NICE=permissive
			2-MAC_FOR_CAPABILITY::SYS_SETHOSTNAME=permissive
			2-MAC_FOR_CAPABILITY::use_kernel_module=permissive
			2-MAC_FOR_CAPABILITY::create_fifo=permissive
			2-MAC_FOR_CAPABILITY::create_block_dev=permissive
			2-MAC_FOR_CAPABILITY::create_char_dev=permissive
			2-MAC_FOR_CAPABILITY::create_unix_socket=permissive
			2-MAC_FOR_CAPABILITY::SYS_LINK=permissive
			2-MAC_FOR_CAPABILITY::SYS_SYMLINK=permissive
			2-MAC_FOR_CAPABILITY::SYS_RENAME=permissive
			2-MAC_FOR_CAPABILITY::SYS_UNLINK=permissive
			2-MAC_FOR_CAPABILITY::SYS_CHMOD=permissive
			2-MAC_FOR_CAPABILITY::SYS_CHOWN=permissive
			2-MAC_FOR_CAPABILITY::SYS_IOCTL=permissive
			2-MAC_FOR_CAPABILITY::SYS_KEXEC_LOAD=permissive
			2-MAC_FOR_CAPABILITY::SYS_PIVOT_ROOT=permissive
			2-MAC_FOR_CAPABILITY::SYS_PTRACE=permissive
			3-COMMENT=-----Enforcing Mode-----
			3-MAC_FOR_FILE=enforcing
			3-MAC_FOR_IOCTL=enforcing
			3-MAC_FOR_ARGV0=enforcing
			3-MAC_FOR_ENV=enforcing
			3-MAC_FOR_NETWORK=enforcing
			3-MAC_FOR_SIGNAL=enforcing
			3-DENY_CONCEAL_MOUNT=enforcing
			3-RESTRICT_CHROOT=enforcing
			3-RESTRICT_MOUNT=enforcing
			3-RESTRICT_UNMOUNT=enforcing
			3-RESTRICT_PIVOT_ROOT=enforcing
			3-RESTRICT_AUTOBIND=enabled
			3-MAX_ACCEPT_ENTRY=2048
			3-MAX_GRANT_LOG=1024
			3-MAX_REJECT_LOG=1024
			3-TOMOYO_VERBOSE=enabled
			3-SLEEP_PERIOD=0
			3-MAC_FOR_CAPABILITY::inet_tcp_create=enforcing
			3-MAC_FOR_CAPABILITY::inet_tcp_listen=enforcing
			3-MAC_FOR_CAPABILITY::inet_tcp_connect=enforcing
			3-MAC_FOR_CAPABILITY::use_inet_udp=enforcing
			3-MAC_FOR_CAPABILITY::use_inet_ip=enforcing
			3-MAC_FOR_CAPABILITY::use_route=enforcing
			3-MAC_FOR_CAPABILITY::use_packet=enforcing
			3-MAC_FOR_CAPABILITY::SYS_MOUNT=enforcing
			3-MAC_FOR_CAPABILITY::SYS_UMOUNT=enforcing
			3-MAC_FOR_CAPABILITY::SYS_REBOOT=enforcing
			3-MAC_FOR_CAPABILITY::SYS_CHROOT=enforcing
			3-MAC_FOR_CAPABILITY::SYS_KILL=enforcing
			3-MAC_FOR_CAPABILITY::SYS_VHANGUP=enforcing
			3-MAC_FOR_CAPABILITY::SYS_TIME=enforcing
			3-MAC_FOR_CAPABILITY::SYS_NICE=enforcing
			3-MAC_FOR_CAPABILITY::SYS_SETHOSTNAME=enforcing
			3-MAC_FOR_CAPABILITY::use_kernel_module=enforcing
			3-MAC_FOR_CAPABILITY::create_fifo=enforcing
			3-MAC_FOR_CAPABILITY::create_block_dev=enforcing
			3-MAC_FOR_CAPABILITY::create_char_dev=enforcing
			3-MAC_FOR_CAPABILITY::create_unix_socket=enforcing
			3-MAC_FOR_CAPABILITY::SYS_LINK=enforcing
			3-MAC_FOR_CAPABILITY::SYS_SYMLINK=enforcing
			3-MAC_FOR_CAPABILITY::SYS_RENAME=enforcing
			3-MAC_FOR_CAPABILITY::SYS_UNLINK=enforcing
			3-MAC_FOR_CAPABILITY::SYS_CHMOD=enforcing
			3-MAC_FOR_CAPABILITY::SYS_CHOWN=enforcing
			3-MAC_FOR_CAPABILITY::SYS_IOCTL=enforcing
			3-MAC_FOR_CAPABILITY::SYS_KEXEC_LOAD=enforcing
			3-MAC_FOR_CAPABILITY::SYS_PIVOT_ROOT=enforcing
			3-MAC_FOR_CAPABILITY::SYS_PTRACE=enforcing
		EOF
		;;
	esac
fi

#echo "-----------------------------------------"
#echo -n "Select profile:"
#read choice

# Exception Policy for Android
make_exception1() {
	#
	# Make initializers.
	#
	for i in '/init_samsung' '/sbin/ccs-editpolicy-agent' '/system/bin/app_process'
		do echo initialize_domain $i
	done
	
	#
	# Allow read/write of policy files for managers.
	#

	#
	# Make patterns for policy directory.
	#
	echo 'file_pattern' $POLICY_DIR'/system_policy.\$-\$-\$.\$:\$:\$.conf'
	echo 'file_pattern' $POLICY_DIR'/exception_policy.\$-\$-\$.\$:\$:\$.conf'
	echo 'file_pattern' $POLICY_DIR'/domain_policy.\$-\$-\$.\$:\$:\$.conf'

	echo 'file_pattern /dev/tty\$'

	echo 'file_pattern /system/lib/\@.so'
	echo 'allow_read /system/lib/\@.so'
	echo 'file_pattern /system/framework/\*.jar'
	echo 'allow_read /system/framework/\*.jar'
	echo 'file_pattern /system/media/audio/\*/\*'
	echo 'allow_read /system/media/audio/\*/\*'
	echo 'file_pattern /system/fonts/\*.ttf'
	echo 'allow_read /system/fonts/\*.ttf'
	echo 'file_pattern /data/tombstones/tombstone_\$'

	echo 'file_pattern /data/dalvik-cache/system@framework@\*.jar@classes.dex'
	echo 'file_pattern /data/dalvik-cache/system@app@\*.jar@classes.dex'
	echo 'file_pattern /data/dalvik-cache/data@app@\*@classes.dex'

	echo 'file_pattern /data/local/tmp/\*.apk'
	echo 'file_pattern /data/local/tmp/\*.apk'

	echo 'file_pattern /data/app/\*.tmp'
	echo 'file_pattern /data/data/\*/databases/\*'
	echo 'file_pattern /data/data/\*/databases/'
	
	echo 'file_pattern /data/dalvik-cache/system@framework@\*.jar@classes.dex'
	echo 'file_pattern /data/dalvik-cache/system@app@\*.apk@classes.dex'
	echo 'file_pattern /data/dalvik-cache/system@app-private@\*.apk@classes.dex'

	echo 'file_pattern /sdcard/dcim/.thumbnails/\$.jpg'
	echo 'file_pattern /sdcard/dcim/.thumbnails/.thumbdata\*'
	echo 'file_pattern /sdcard/dcim/.thumbnails/.thumbdata3--\$'

	echo 'path_group SYSTEM_APK /system/app/\@.apk'

	echo 'path_group SYS_FILES /sys/kernel/ipv4/tcp_wmem_min'
	echo 'path_group SYS_FILES /sys/kernel/ipv4/tcp_wmem_def'
	echo 'path_group SYS_FILES /sys/kernel/ipv4/tcp_wmem_max'
	echo 'path_group SYS_FILES /sys/kernel/ipv4/tcp_rmem_min'
	echo 'path_group SYS_FILES /sys/kernel/ipv4/tcp_rmem_def'
	echo 'path_group SYS_FILES /sys/kernel/ipv4/tcp_rmem_max'

	echo 'path_group BATTERY /sys/devices/platform/\*battery\*/power_supply/ac/online'
	echo 'path_group BATTERY /sys/devices/platform/\*battery\*/power_supply/battery/\@'
	echo 'allow_read @BATTERY'

	#App. specific data files
	echo 'file_pattern /data/data/com.android.browser/cache/webviewCache/\*'
	echo 'file_pattern /data/data/com.android.browser/app_thumbnails/\*'

	#...TODO	
}


# Initialize EXCEPTION POLICY
if file_exists exception_policy.conf
then
	echo "exception_policy.conf already existing. Exception policy won't be initialized"
else
	echo "Creating exception policy"

	
	#
	# Make patterns for /proc/[number]/ and /proc/self/ directory.
	# Allow reading information for current process (/proc/self/...).
	#
	make_exception > exception_policy.conf

	#
	# Make other exceptions
	#
	make_exception1 >> exception_policy.conf
fi

#Adding MANAGERS
if file_exists manager.conf
then
	echo "manager.conf already existing. Manager won't be initialized"
else
	echo "Creating manager"
cat > manager.conf <<- EOF
	/sbin/ccs-savepolicy
	/sbin/ccs-setprofile
	/sbin/ccs-editpolicy-agent
EOF
fi


#Create SYSTEM_policy (empty)
if file_exists system_policy.conf 
then
	echo "system_policy.conf already existing. System policy won't be initialized"
else
	echo "Creating system policy (empty)"
	: > system_policy.conf
fi

#Create DOMAIN_policy
if file_exists domain_policy.conf 
then
	echo "domain_policy.conf already existing. Domain policy won't be initialized"
else
	echo "Creating domain policy"
	#: > system_policy.conf
	/sbin/ccs-savepolicy -d > /dev/null
fi

if file_exists profile.conf 
then
	echo ""
	echo "If you want to set learning profile:"
	echo "1) ccs-loadpolicy p"
	echo "2) ccs-setprofile -r 1 '<kernel>'"
	echo "3) ccs-savepolicy d"
	echo "then restart your system."
	echo "ATTENTION:"
	echo "  Before setting 'enforcing' mode, don't forget to add "
	echo "  allow_read/write for policy files to the domains of managers "
	echo "  ( /sbin/ccs-savepolicy  /sbin/ccs-setprofile  /sbin/ccs-editpolicy-agent )."
fi
