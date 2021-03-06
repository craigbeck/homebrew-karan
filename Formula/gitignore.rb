class Gitignore < Formula
  homepage "https://github.com/karan/joe"
  url "https://pypi.python.org/packages/source/j/joe/joe-0.0.7.tar.gz"
  sha1 "c14d59f5ab10f17d7a4b1777e3e96e203595e65c"

  depends_on :python if MacOS.version <= :snow_leopard

  resource "docopt" do
    url "https://github.com/docopt/docopt/archive/0.6.1.tar.gz"
    sha1 "2228a1bc58665664550a4552fb53906704918866"
  end

  resource "GitPython" do
    url "https://pypi.python.org/packages/source/G/GitPython/GitPython-1.0.2.tar.gz#md5=d92d96a8da0fc77cf141d3e16084e094"
    sha1 "f6ff3a7dce04fac9028845ad5f0d0e1ee773d6fd"
  end

  def install
    ENV["PYTHONPATH"] = libexec/"vendor/lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"

    resource("docopt").stage { system "python", *Language::Python.setup_install_args(libexec/"vendor") }
    resource("GitPython").stage { system "python", *Language::Python.setup_install_args(libexec/"vendor") }

    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/joe", "ls"
  end
end
