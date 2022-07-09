# frozen_string_literal: true

image_url = ENV.fetch('ALPINE_IMAGE_URL', 'https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.0-x86_64.iso')

package 'curl'

execute "curl #{image_url} -o alpine.iso" do
  not_if 'test -e alpine.iso'
end
