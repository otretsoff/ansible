#!/bin/bash

DIALOG=dialog
DOMAIN="@main.ru"
LOGIN=""

TEMPFILE=`mktemp /tmp/otr.XXXXXX`
trap "rm -f $TEMPFILE" 0 1 2 5 15

# функция для вывода информационного окна
InfoDialog() {
    ${DIALOG} --msgbox "$1" 5 70
}

installationProcess() {

USR=${LOGIN}${DOMAIN}
    case $1 in
        p.1)
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/RedOS-Base.repo -O /etc/yum.repos.d/RedOS-Base.repo 
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/RedOS-Updates.repo -O /etc/yum.repos.d/RedOS-Updates.repo
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/RedOS-Local.repo -O /etc/yum.repos.d/RedOS-Local.repo
		dnf makecache
		dnf update --nobest -y
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/crontab.bak -O /home/crontab.bak
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/installUSR.sh -O /home/$USR/installUSR.sh
		crontab /home/crontab.bak
                wget -q http://repo.main.ru/redos/7.3/x86_64/cron.run.sh -O /home/cron.run.sh
                wget -q http://repo.main.ru/redos/7.3/x86_64/cron.shutdown.sh -O /home/cron.shutdown.sh
                chmod +x /home/cron.shutdown.sh
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/timesyncd.conf -O /etc/systemd/timesyncd.conf
		systemctl disable ntpd --now
                systemctl disable chronyd --now
                systemctl enable systemd-timesyncd --now
		usermod -aG cdrom $USR
                usermod -aG floppy $USR
                usermod -aG users $USR
		echo "[USER]" >> /var/lib/AccountsService/users/${LOGIN}
                echo "Language=" >> /var/lib/AccountsService/users/${LOGIN}
                echo "Session=cinnamon" >> /var/lib/AccountsService/users/${LOGIN}
                echo "XSession=cinnamon" >> /var/lib/AccountsService/users/${LOGIN}
                echo "Icon=/home/"$USR"/.face/" >> /var/lib/AccountsService/users/${LOGIN}
                echo "SystemAccount=false" >> /var/lib/AccountsService/users/${LOGIN}
		dnf install x11vnc -y
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/vncpasswd -O /etc/vncpasswd
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/x11vnc.service -O /lib/systemd/system/x11vnc.service
		systemctl daemon-reload
		systemctl enable x11vnc.service
		systemctl start x11vnc.service
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/We10X.zip -O /home/$USR/We10x.zip
		unzip /home/$USR/We10x.zip 
		cp -r /home/$USR/We10X /usr/share/icons/ 
		dnf install r7-office* -y
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/182638b1-4807-4cfc-9f2a-cf11a04cb147.lickey -O /etc/r7-office/license/182638b1-4807-4cfc-9f2a-cf11a04cb147.lickey
		chmod 777 /etc/r7-office/license/182638b1-4807-4cfc-9f2a-cf11a04cb147.lickey
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/cupsd.conf -O /etc/cups/cupsd.conf
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/cups-files.conf -O /etc/cups/cups-files.conf
		systemctl restart cups
		dnf install nemo-fileroller -y
		dnf install gscan2pdf -y
		dnf install pdfshuffler -y
		dnf install cuneiform -y
		dnf install tesseract tesseract-langpack-rus -y
		dnf install yandex* -y
		dnf install Spark* -y
		dnf remove pidgin -y
		dnf install hplip hplip-gui -y
		dnf install cifs-utils autofs -y

		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/50-redos.conf -O /etc/ssh/sshd_config.d/50-redos.conf
		systemctl restart sshd
		
		sudo wget -q http://repo.main.ru/redos/7.3/x86_64/setup/info -O /etc/info
		sudo dnf install conky -y

		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/auto.samba -O /etc/auto.samba
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/auto.master -O /etc/auto.master
		systemctl enable autofs --now
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/bridge.jpg -O /usr/share/backgrounds/redos/normalish/bridge.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/bridge.jpg -O /usr/share/backgrounds/redos/standart/bridge.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/bridge.jpg -O /usr/share/backgrounds/redos/wide/bridge.jpg

	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_1.jpg -O /usr/share/backgrounds/redos/normalish/desktop_1.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_1.jpg -O /usr/share/backgrounds/redos/standart/desktop_1.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_1.jpg -O /usr/share/backgrounds/redos/wide/desktop_1.jpg

	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_2.jpg -O /usr/share/backgrounds/redos/normalish/desktop_2.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_2.jpg -O /usr/share/backgrounds/redos/standart/desktop_2.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_2.jpg -O /usr/share/backgrounds/redos/wide/desktop_2.jpg

	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_3.jpg -O /usr/share/backgrounds/redos/normalish/desktop_3.jpg
       		wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_3.jpg -O /usr/share/backgrounds/redos/standart/desktop_3.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_3.jpg -O /usr/share/backgrounds/redos/wide/desktop_3.jpg

	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_4.jpg -O /usr/share/backgrounds/redos/normalish/desktop_4.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_4.jpg -O /usr/share/backgrounds/redos/standart/desktop_4.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/desktop_4.jpg -O /usr/share/backgrounds/redos/wide/desktop_4.jpg

	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/petr_and_fevronia.jpg -O /usr/share/backgrounds/redos/normalish/petr_and_fevronia.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/petr_and_fevronia.jpg -O /usr/share/backgrounds/redos/standart/petr_and_fevronia.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/petr_and_fevronia.jpg -O /usr/share/backgrounds/redos/wide/petr_and_fevronia.jpg

	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/train.jpg -O /usr/share/backgrounds/redos/normalish/train.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/train.jpg -O /usr/share/backgrounds/redos/standart/train.jpg
	        wget http://repo.main.ru/redos/7.3/x86_64/setup/wall/train.jpg -O /usr/share/backgrounds/redos/wide/train.jpg
		TypeDialog
            ;;
		p.2)
		KES
	    ;;
        p.2.1)
		clear
                dnf -y install klnagent*
                dnf -y install kesl-11*
                dnf -y install kesl-gui*
                sudo /opt/kaspersky/klnagent64/lib/bin/setup/postinstall.pl
                sleep 20
                sudo /opt/kaspersky/kesl/bin/kesl-setup.pl
                KES
            ;;
		p.2.2)
		clear
                sudo /opt/kaspersky/klnagent64/lib/bin/setup/postinstall.pl
                KES
            ;;
		p.2.3)
		clear
                sudo /opt/kaspersky/kesl/bin/kesl-setup.pl
                KES
            ;;
    	p.3)
		RDP
	   ;;
        p.3.1)
                dnf install xrdp xorgxrdp -y
		groupadd tsusers
		wget -q http://repo.main.ru/redos/7.3/x86_64/rdpconfig/sesman.ini -O /etc/xrdp/sesman.ini
                wget -q http://repo.main.ru/redos/7.3/x86_64/rdpconfig/xrdp.ini -O /etc/xrdp/xrdp.ini
		wget -q http://repo.main.ru/redos/7.3/x86_64/rdpconfig/logo.png -O /etc/xrdp/logo.png
                wget -q http://repo.main.ru/redos/7.3/x86_64/rdpconfig/xrdp_keyboard.ini -O /etc/xrdp/xrdp_keyboard.ini
                wget -q http://repo.main.ru/redos/7.3/x86_64/rdpconfig/desktop -O /etc/sysconfig/desktop
		systemctl enable xrdp --now
		systemctl restart sssd
		RDP
            ;;
	p.3.2)
		usermod -aG tsusers $USR
		systemctl restart xrdp
		RDP
			;;
    	p.4)
		Comunications
	   ;;
        p.4.1)
		dnf install trueconf* -y
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/trueconf.repo -O /etc/yum.repos.d/trueconf.repo
                Comunications
	   ;;
			p.4.2)
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/mailagent.tar.gz -O /home/$USR/mailagent.tar.gz
				tar -xvf /home/$USR/mailagent.tar.gz
				rm /home/$USR/mailagent.tar.gz
                chmod 777 -R /home/$USR/.mailagent/
                chmod +x /home/$USR/.mailagent/agent
                sed 's/USR/'$USR'/g' /home/$USR/.mailagent/mailagent.desktop
                cp /home/$USR/.mailagent/mailagent.desktop /home/$USR/Рабочий\ стол/mailagent.desktop
                chmod 777 /home/$USR/Рабочий\ стол/mailagent.desktop
                Comunications
            ;;
	p.4.3)
		dnf install flatpak
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
		flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
		flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo
		flatpak install flathub org.telegram.desktop -y
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/Telegram.desktop -O '/home/'$USR'/Рабочий стол/Telegram.desktop'
		Comunications
            ;;
	p.4.5)
		dnf install zoom -y
		Comunications
	   ;;
	p.4.6)
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/armgs.zip -O /home/Administrator/armgs.zip
		unzip /home/Administrator/armgs.zip -d /opt
		rm /home/Administrator/armgs.zip
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/%d0%90%d0%a0%d0%9c%20%d0%93%d0%a1.desktop -O /usr/share/applications/armgs.desktop
		chmod +x /opt/armgs/armgs
		;;
	p.4.7)
		dnf install flatpak -y
                flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
                flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
                flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo
                flatpak install flathub com.github.eneshecan.WhatsAppForLinux -y
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/WhatsApp.desktop -O '/home/'$USR'/Рабочий стол/WhatsApp.desktop'
		chmod 777 '/home/'$USR'/Рабочий стол/WhatsApp.desktop'
                Comunications
			;;
    	p.5)
        Vipnet
	   ;;
        p.5.1)
                dnf install vipnetclient* -y
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/vipnet.conf -O /etc/vipnet.conf
                Vipnet
            ;;
		        p.5.2)
					wget -q http://repo.main.ru/redos/7.3/x86_64/setup/Coordinator.sh -O Coordinator.sh
					chmod +x Coordinator.sh
					su $USR ./Coordinator.sh
					rm Coordinator.sh
                Vipnet
            ;;	
    	p.6)
        Crypto
	   ;;
        p.6.1)
		clear
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/CryptoPro_4.09944.zip -O /home/$USR/CryptoPro_4.09944.zip
                cd /home/$USR
                unzip /home/$USR/CryptoPro_4.09944.zip
                cd /home/$USR/CryptoPro_4.09944
                rm /home/$USR/CryptoPro_4.09944.zip
                chmod +x /home/$USR/CryptoPro_4.09944/install_gui.sh
                ./install_gui.sh
                sleep 2
                dnf install ./cprocsp-rdr-jacarta*.rpm -y
                dnf install ./cprocsp-pki*rpm -y
                dnf install ifcplugin-chromium.x86_64 -y
                dnf install ifd-rutokens -y
                dnf install nemo-gostcryptogui.noarch -y
                dnf install token-manager -y
                ln -s /opt/cprocsp/bin/amd64/certmgr /usr/bin/certmgr
                ln -s /opt/cprocsp/bin/amd64/csptest /usr/bin/csptest
                ln -s /opt/cprocsp/sbin/amd64/cpconfig /usr/bin/cpconfig
				rm -Rf /home/$USR/CryptoPro_4.09944
                cd /home/$USR
                Crypto
            ;;
			 p.6.2)
			clear
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/CryptoPro_5.0.tgz -O /home/$USR/CryptoPro_5.0.tgz
                cd /home/$USR
                tar -xvf /home/$USR/CryptoPro_5.0.tgz
                cd /home/$USR/linux-amd64
                rm /home/$USR/CryptoPro_5.0.tgz
                chmod +x /home/$USR/CryptoPro_5.0.tgz/install_gui.sh
                ./install_gui.sh
                sleep 2
                dnf install ./cprocsp-rdr-jacarta*.rpm -y
                dnf install ./cprocsp-pki*rpm -y
                dnf install ifcplugin-chromium.x86_64 -y
                dnf install ifd-rutokens -y
                dnf install nemo-gostcryptogui.noarch -y
                dnf install token-manager -y
                ln -s /opt/cprocsp/bin/amd64/certmgr /usr/bin/certmgr
                ln -s /opt/cprocsp/bin/amd64/csptest /usr/bin/csptest
                ln -s /opt/cprocsp/sbin/amd64/cpconfig /usr/bin/cpconfig
				rm -Rf /home/$USR/CryptoPro_4.09944
                cd /home/$USR
                Crypto
            ;;
	p.6.3)
		clear
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/Certificates.zip -O tmp.zip
		unzip tmp.zip -d /
		rm tmp.zip
                Crypto
            ;;
	p.7)
                wget -q http://repo.main.ru/redos/7.3/x86_64/setup/timesyncd.conf -O /etc/systemd/timesyncd.conf
                systemctl disable ntpd --now
                systemctl disable chronyd --now
                systemctl enable systemd-timesyncd --now
		;;
    	p.8)
		Desktop
	   ;;
        p.8.1)
			dnf groupinstall cinnamon-desktop -y
            dnf groupinstall x11 -y
            systemctl set-default graphical.target
            Desktop
            ;;
        p.8.2)
            dconf dump /org/cinnamon/ > /home/$USR/cinnamon_desktop_backup
            Desktop
            ;;
	p.8.3)
		dnf remove mate*
		Desktop
	    ;;
		p.8.4)
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/installUSR.sh -O installUSR.sh
		chmod +x installUSR.sh
		su $USR ./installUSR.sh
		rm installUSR.sh
		Desktop
	    ;;
		p.8.5)
        dnf install plank -y
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/Planc.zip -O /home/$USR/Plank.zip
        unzip /home/$USR/Plank.zip
		rm /home/$USR/Plank.zip
        chmod +x Mac.sh
		su $USR ./Mac.sh
		rm Mac.sh
        plank
		Desktop
	    ;;
	p.9)
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/95-usb.rules -O /etc/udev/rules.d/95-usb.rules
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/96-usb-allow.rules -O /etc/udev/rules.d/96-usb-allow.rules
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/98-mtp.rules -O /etc/udev/rules.d/98-mtp.rules
		udevadm control --reload-rules
	   ;;
	p.10)
		Wine
	   ;;
	p.10.1)
		dnf install wine -y
		dnf install winetricks -y
		Wine
	    ;;
	p.10.2)
		clear
		su $USR winecfg
		Wine
	    ;;
	p.10.3)
		clear
		su $USR winetricks
		Wine
	    ;;
	p.13)
		Devices
	   ;;
	p.13.1)
		dnf install cndrvsane-drc225 -y
		Devices
	   ;;
	p.13.2)
	   clear
	   wget -q http://repo.main.ru/redos/7.3/x86_64/setup/linux-brprinter-installer-2.2.3-1 -O linux-brprinter-installer-2.2.3-1
	   chmod +x linux-brprinter-installer-2.2.3-1
		./linux-brprinter-installer-2.2.3-1
		rm linux-brprinter-installer-2.2.3-1
        Devices
	   ;;
        p.13.3)
	        clear
		hp-plugin
        	Devices
           ;;
	p.16)
		dnf install flatpak -y
                flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
                flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
                flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo
		flatpak install flathub org.kde.krita -y
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/Krita.desktop -O '/home/'$USR'/Рабочий стол/Krita.desktop'
                chmod 777 '/home/'$USR'/Рабочий стол/Krita.desktop'
                TypeDialog
	   ;;
        p.17)
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/auto.samba -O /etc/auto.samba
		wget -q http://repo.main.ru/redos/7.3/x86_64/setup/auto.master -O /etc/auto.master
		systemctl restart autofs
                TypeDialog
           ;;
                p.Ex)
				clear
				exit
			;;
        esac
}

TypeDialog() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "Выбирите тип установки" 25 50 18 \
		"p.1" "ПО по умолчанию" \
		"p.2" "Kaspersky" \
		"p.3" "RDP" \
		"p.4" "Коммуникаторы" \
		"p.5" "VipNet" \
		"p.6" "CryptoPro" \
		"p.7" "Fix TIME" \
		"p.8" "Оболочка" \
         	"p.9" "Блокировка внешних накопителей" \
		"p.10" "Wine" \
		"p.13" "Устройства" \
		"p.16" "Krita" \
		"p.17" "Переподключить DFS" \
                "p.18" "Обновление" \
		"p.Ex" "Выход" 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        TypeDialog
        ;;
    1|255)
        InfoDialog "Выполнен выход из инсталятора"
	clear
        exit
        ;;
    esac

}

Devices() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "Устройства" 25 50 18 \
		"p.13.1" "Установка Canon scan driver" \
                "p.13.2" "Установка принтера Brother" \
		"p.13.3" "HP-PLUGIN" 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        Devices
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}

RDP() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "RDP" 25 50 18 \
		"p.3.1" "Установка RDP сервера" \
		"p.3.2" "Доступ к RDP для "${LOGIN} 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        RDP
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}
KES() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "RDP" 25 50 18 \
		"p.2.1" "Установка и настройка" \
		"p.2.2" "Настроить Агент" \
		"p.2.3" "Настроить Антивирус "${LOGIN} 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        RDP
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}
Desktop() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "Оболочка" 25 50 18 \
		"p.8.1" "Установка Cinnamon Desktop" \
		"p.8.2" "Резервная копия настроек Cinnamon" \
		"p.8.3" "Удалить MATE" \
		"p.8.4" "Настроить тему Windows" \
		"p.8.5" "Настроить тему Mac" 2> ${TEMPFILE}

    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        Desktop
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}
Crypto() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "КриптоПро" 25 50 18 \
		"p.6.1" "Установка CryptoPro 4" \
		"p.6.2" "Установка CryptoPro 5" \
		"p.6.3" "Установка корневых сертификатов" 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        Crypto
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}
Vipnet() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "VipNet" 25 50 18 \
		"p.5.1" "Установка VipNet Client" \
		"p.5.2" "Смена координатора" 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        Vipnet
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}

Wine() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "Wine" 25 50 18 \
		"p.10.1" "Установка Wine" \
		"p.10.2" "Wine конфигуратор" \
		"p.10.3" "Winetricks" 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        Wine
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}

Comunications() {
	clear
    ${DIALOG} --title "РедОС МКУ 'ЦБДО' инсталятор." --menu "Коммуникаторы" 25 50 18 \
		"p.4.1" "Trueconf Client" \
		"p.4.2" "MailAgent" \
		"p.4.3" "Telegram" \
		"p.4.5" "Zoom" \
		"p.4.6" "АРМ ГС" \
		"p.4.7" "WhatsApp" 2> ${TEMPFILE}
    case $? in
    0)
	clear
	installationProcess `cat ${TEMPFILE}`
        Comunications
        ;;
    1|255)
	    clear
        TypeDialog
        ;;
    esac

}
enterUserName() {
	${DIALOG} --title "Ввод данных" --clear \
	--inputbox "Введите имя пользователя" 16 51 2> ${TEMPFILE}

retval=$?

case $retval in
  0)
     LOGIN=`cat ${TEMPFILE}`
	 TypeDialog
    ;;
  1|255)
		InfoDialog "Выполнен выход из инсталятора"
		clear
		exit
    ;;
esac

}

dnf install dialog -y
enterUserName

