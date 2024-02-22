#!/bin/bash
export IPT="iptables"

# Локальная сеть
export LAN1=enp2s0

# Очищаем правила
$IPT -F
$IPT -F -t nat
$IPT -F -t mangle
$IPT -X
$IPT -t nat -X
$IPT -t mangle -X

# Запрещаем все, что не разрешено
$IPT -P INPUT DROP
$IPT -P OUTPUT DROP
$IPT -P FORWARD DROP

# Разрешаем localhost и локалку
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A INPUT -i $LAN1 -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT
$IPT -A OUTPUT -o $LAN1 -j ACCEPT
# Рзрешаем пинги
$IPT -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# разрешаем установленные подключения
$IPT -A INPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -p all -m state --state ESTABLISHED,RELATED -j ACCEPT

# Отбрасываем неопознанные пакеты
$IPT -A INPUT -m state --state INVALID -j DROP
$IPT -A FORWARD -m state --state INVALID -j DROP

# Отбрасываем нулевые пакеты
$IPT -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

# Закрываемся от syn-flood атак
$IPT -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
$IPT -A OUTPUT -p tcp ! --syn -m state --state NEW -j DROP

#открываем дотуп к SSH
$IPT -A INPUT -i $LAN1 -p tcp --dport 22 -j ACCEPT
#открываем RDP
$IPT -A INPUT -i $LAN1 -p tcp --dport 3389 -j ACCEPT
#открываем SMB
$IPT -A INPUT -i $LAN1 -p tcp -m multiport --dport 137,138,139,445 -j ACCEPT
#открываем DNS, AD
$IPT -A INPUT -i $LAN1 -p tcp -m multiport --dport 53,135,389,636,3268,3269,53,88,8088 -j ACCEPT
#открываем DHCP, DNS, AD
$IPT -A INPUT -i $LAN1 -p udp -m multiport --dport 67,53,389,88,69,8088 -j ACCEPT
#открываем порты KES
$IPT -A INPUT -i $LAN1 -p tcp -m multiport --dport 13000,14000,15000,15001 -j ACCEPT

# Сохраняем правила
/sbin/iptables-save  > /etc/sysconfig/iptables
