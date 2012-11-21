require 'formula'

class Jhove < Formula
  homepage 'http://jhove.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/jhove/jhove/JHOVE%201.8/jhove-1_8.tar.gz'
  version '1.8'
  sha1 'f807689a9e7c9074996e2a2fb209e53066b7e6f3'

  def install
    inreplace "conf/jhove.conf", "/users/stephen/projects/jhove", libexec
    inreplace "jhove.tmpl" do |s|
      s.change_make_var! "JHOVE_HOME", libexec
      s.change_make_var! "JAVA_HOME", "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
      s.gsub! "${JHOVE_HOME}/bin/", "${JHOVE_HOME}/"

      # this is a fix for a bug which should be fixed soon
      s.change_make_var! "EXTRA_JARS", "${JHOVE_HOME}/JhoveView.jar"
    end

    bin.install "jhove.tmpl" => "jhove"
    libexec.install Dir['bin/*.jar']
    libexec.install "conf"
  end

  def test
    system "#{bin}/jhove"
  end
end
