# frozen_string_literal: true

desc "provisionate alpine at termux using qemu"
task :provision do
  sh 'itamae local alpine-qemu.rb --tmp_dir=$TMPDIR'
end

desc "setup alpine instalation"
task :install do
  sh 'qemu-system-x86_64 -hda alpine.img -cdrom alpine.iso -boot d -m 1024 -nographic'
end

desc "start alpine image"
task :start do
  sh 'qemu-system-x86_64 -hda alpine.img -boot c -m 1024 -nographic'
end
