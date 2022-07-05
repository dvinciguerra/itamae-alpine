#!/usr/bin/env ruby
# frozen_string_literal: true

require "specinfra_termux"

image_url =  ENV.fetch('ALPINE_IMAGE_URL', 'https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.0-x86_64.iso')

package "unstable-repo"

# package "qemu-system-x64_64"
package "qemu-user-x86-64"
package "qemu-utils"

package "curl"

execute "curl https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.0-x86_64.iso -o alpine.iso" do
  not_if "test -e alpine.iso"
end

execute "qemu-img create -f qcow2 alpine.img 512m" do
  not_if "test -e alpine.img"
end

execute "qemu-system-x86_64 -hda alpine.img -cdrom alpine.iso -boot d -m 512 -nographic"



