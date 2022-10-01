#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "yaml"
require "faraday"
require "specinfra_termux"

ALPINE_BASE_URL =
  'https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64'

ALPINE_LATEST_RELEASES =
  "#{ALPINE_BASE_URL}/latest-releases.yaml"

request = Faraday.get(ALPINE_LATEST_RELEASES)
raise "Unable to fetch Alpine versions!" unless request.success?

versions =
  YAML.unsafe_load(request.body, symbolize_names: true)

standard_version =
  versions.find { |version| version[:title] == 'Standard' }

image_url =
  ENV.fetch('ALPINE_IMAGE_URL', "#{ALPINE_BASE_URL}/#{standard_version[:iso]}")

package "unstable-repo"

package "curl"
package "qemu-user-x86-64"
package "qemu-utils"
# package "qemu-system-x64_64"

# download iso
execute "curl #{image_url} -o alpine.iso" do
  not_if "test -e alpine.iso"
end

# create disk
execute "qemu-img create -f qcow2 alpine.img 512m" do
  not_if "test -e alpine.img"
end

puts "
Now execute the following command to install alpine:
  qemu-system-x86_64 -hda alpine.img -cdrom alpine.iso -boot d -m 512 -nographic
"

# execute "qemu-system-x86_64 -hda alpine.img -cdrom alpine.iso -boot d -m 512 -nographic"

# include_recipe './cookbooks/alpine/default'
