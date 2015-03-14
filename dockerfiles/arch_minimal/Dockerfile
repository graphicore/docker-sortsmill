FROM arch/base

COPY mirrorlist /etc/pacman.d/mirrorlist

# this takes forever because there's not enough entropy created by docker
# maybe playing with the keyboard helps a bit, if not at least it feels
# like it helps ;-)
RUN	pacman-key --init \
	&& pacman-key --populate archlinux

# update everything
RUN	pacman -Syy --noconfirm \
	&& pacman -S archlinux-keyring --noconfirm \
	&& pacman -Syyu --noconfirm
