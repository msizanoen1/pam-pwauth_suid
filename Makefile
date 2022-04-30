.PHONY: all

all: pwauth_suid_helper pam_pwauth_suid.so

clean:
	rm -f pwauth_suid_helper pam_pwauth_suid.so

pwauth_suid_helper:
	cc -O3 -o pwauth_suid_helper pwauth_suid_helper.c -lcrypt

pam_pwauth_suid.so:
	cc -O3 -fPIC -shared -o pam_pwauth_suid.so -DPATH_HELPER="\"/usr/local/libexec/pwauth_suid_helper\"" pam_pwauth_suid.c -lpam

install:
	install -m 4755 pwauth_suid_helper /usr/local/libexec
	install -m 0755 -d /usr/local/lib/security
	install -m 0755 pam_pwauth_suid.so /usr/local/lib/security

