# frozen_string_literal: true

execute 'qemu-img create -f qcow2 alpine.img 512m' do
  not_if 'test -e alpine.img'
end
