Installation
============

.. contents:: Topics

.. _getting_ansible:

从 Github 获取 Ansible
```````````````````````

如果你有一个 Github 账户，可以跟进 Ansible 在 Github 的项目: `Github project <https://github.com/ansible/ansible>`_ 我们在这里保持对 bugs 和 feature ideas 的跟踪。

.. _what_will_be_installed:

需要安装些什么
```````````````````````````````

Ansible 默认通过 SSH 协议管理机器。

安装 Ansible 之后，不需要启动或运行一个后台进程，或是添加一个数据库。只要在一台电脑 (可以是一台笔记本) 上安装好，就可以通过这台电脑管理一组远程的机器.在远程被管理的机器上，不需要安装运行任何软件，因此升级Ansible版本不会有太多问题。

.. _what_version:

选择哪一个版本?
`````````````````````

因为 Ansible 可以很简单的从源码运行，且不必在远程被管理机器上安装任何软件，很多 Ansible 用户会跟进使用开发版本。

Ansible 一般每两个月出一个发行版本。小 bugs 一般在下一个发行版本中修复，并在稳定分支中做 backports。大 bugs 会在必要时出一个维护版本，不过这不是很频繁。

若你希望使用 Ansible 的最新版本，并且你使用的操作系统是 Red Hat Enterprise Linux (TM), CentOS, Fedora, Debian, Ubuntu，我们建议使用系统的软件包管理器。

另有一种选择是通过 "pip" 工具安装，"pip" 是一个安装和管理 Python 包的工具。

若你希望跟进开发版本，想使用和测试最新的功能特性，我们会分享如何从源码运行 Ansible 的方法。从源码运行程序不需要进行软件安装。


.. _control_machine_requirements:

对管理主机的要求
````````````````````````````

目前，只要机器上安装了 Python 2.6 或 Python 2.7 (Windows 系统不可以做控制主机)，都可以运行 Ansible。

主机的系统可以是 Red Hat, Debian, CentOS, OS X, BSD 的各种版本等等。
  
.. note::

自 2.0 版本开始，Ansible 使用了更多句柄来管理它的子进程，对于 OS X 系统，你需要增加 ulimit 值才能使用 15 个以上子进程，方法 
sudo launchctl limit maxfiles 1024 2048，否则你可能会看见 ”Too many open file” 的错误提示。


.. _managed_node_requirements:

对托管节点的要求
`````````````````````````

通常我们使用 ssh 与托管节点通信，默认使用 sftp。如果 sftp 不可用，可在 ansible.cfg 配置文件中配置成 scp 的方式。
在托管节点上也需要安装 Python 2.4 或以上的版本。如果版本低于 Python 2.5 ，还需要额外安装一个模块:

* ``python-simplejson`` 

.. note::

   没安装 python-simplejson，也可以使用 Ansible 的 "raw" 模块和 script 模块，因此从技术上讲，你可以通过 Ansible 的 "raw" 模块安装 python-simplejson，之后就可以使用 Ansible 的所有功能了。

.. note::

   如果托管节点上开启了 SElinux，你需要安装 libselinux-python，这样才可使用 Ansible 中与 copy/file/template 相关的函数。你可以通过 Ansible 的 yum 模块在需要的托管节点上安装 libselinux-python。

.. note::

   Python 3 与 Python 2 是稍有不同的语言，大多数 Python 程序还不能在 Python 3 中正确运行。一些 Linux 发行版 (Gentoo, Arch) 没有默认安装 Python 2.X 解释器。在这些系统上，你需要安装一个 Python 2.X 解释器，并在 inventory (详见 :doc:`intro_inventory`) 中设置 'ansible_python_interpreter' 变量指向你的 2.X Python.你可以使用 'raw' 模块在托管节点上远程安装 Python 2.X。
	例如：``ansible myhost --sudo -m raw -a "yum install -y python2 python-simplejson"``
	这条命令可以通过远程方式在托管节点上安装 Python 2.X 和 simplejson 模块。
   
   Red Hat Enterprise Linux, CentOS, Fedora and Ubuntu 等发行版都默认安装了 2.X 的解释器，包括几乎所有的 Unix 系统也是如此。
   
   

.. _installing_the_control_machine:

安装管理主机
``````````````````````````````

.. _from_source:

从源码运行
+++++++++++++++++++

从项目的 checkout 中可以很容易运行 Ansible，Ansible 的运行不要求 root 权限，也不依赖于其他软件，不要求运行后台进程，也不需要设置数据库.因此我们社区的许多用户一直使用 Ansible 的开发版本，这样可以利用最新的功能特性，也方便对项目做贡献.因为不需要安装任何东西，跟进Ansible的开发版相对于其他开源项目要容易很多。

从源码安装的步骤

.. code-block:: bash

    $ git clone git://github.com/ansible/ansible.git --recursive
    $ cd ./ansible

使用 Bash:

.. code-block:: bash

    $ source ./hacking/env-setup

使用 Fish::

    $ . ./hacking/env-setup.fish

If you want to suppress spurious warnings/errors， use::

    $ source ./hacking/env-setup -q


如果没有安装 pip， 请先安装对应于你的 Python 版本的 pip::

    $ sudo easy_install pip

以下的 Python 模块也需要安装 [1]_::

    $ sudo pip install paramiko PyYAML Jinja2 httplib2 six

注意，当更新 Ansible 版本时，不只要更新 git 的源码树，也要更新 git 中指向 Ansible 自身模块的 "submodules" (不是同一种模块)

.. code-block:: bash

    $ git pull --rebase
    $ git submodule update --init --recursive

一旦运行 env-setup 脚本，就意味着 Ansible 从源码中运行起来了.默认的 inventory文件是 /etc/ansible/hosts.inventory 文件也可以另行指定 (详见 :doc:`intro_inventory`) :

.. code-block:: bash

    $ echo "127.0.0.1" > ~/ansible_hosts
    $ export ANSIBLE_HOSTS=~/ansible_hosts

你可以在手册的后续章节阅读更多关于 inventory 文件的使用，现在让我们测试一条 ping 命令:

.. code-block:: bash

    $ ansible all -m ping --ask-pass

你也可以使用命令 "sudo make install" 

.. _from_yum:

通过Yum安装最新发布版本
+++++++++++++++++++++++

通过 Yum 安装 RPMs 适用于 `EPEL <http://fedoraproject.org/wiki/EPEL>`_ 6， 7， 以及仍在支持中的 Fedora 发行版.

托管节点的操作系统版本可以是更早的版本 (如 EL5)， 但必须安装 Python 2.4 或更高版本的 Python.

Fedora 用户可直接安装 Ansible， 但 RHEL 或 CentOS 用户，需要 `配置 EPEL <http://fedoraproject.org/wiki/EPEL>`_

.. code-block:: bash

    # install the epel-release RPM if needed on CentOS， RHEL， or Scientific Linux
    $ sudo yum install ansible

你也可以自己创建 RPM 软件包.在 Ansible 项目的 checkout 的根目录下，或是在一个 tarball 中，使用 ``make rpm`` 命令创建 RPM 软件包。
然后可分发这个软件包或是使用它来安装 Ansible。在创建之前，先确定你已安装了 ``rpm-build``， ``make``， and ``python2-devel`` .

.. code-block:: bash

    $ git clone git://github.com/ansible/ansible.git
    $ cd ./ansible
    $ make rpm
    $ sudo rpm -Uvh ~/rpmbuild/ansible-*.noarch.rpm

.. _from_apt:

通过 Apt (Ubuntu) 安装最新发布版本
++++++++++++++++++++++++++++++++++

Ubuntu 编译版可在 PPA 中获得: ` <https://launchpad.net/~ansible/+archive/ansible>`_.

配置 PPA 及安装 Ansible，执行如下命令:

.. code-block:: bash

    $ sudo apt-get install software-properties-common
    $ sudo apt-add-repository ppa:ansible/ansible
    $ sudo apt-get update
    $ sudo apt-get install ansible

.. note:: 在早期 Ubuntu 发行版中，"software-properties-common" 名为 "python-software-properties"。

也可从源码 checkout 中创建 Debian/Ubuntu 软件包，执行:

.. code-block:: bash

    $ make deb

你或许也想从源码中运行最新发行版本，可看前面的说明.

.. _from_pkg:

通过 Portage (Gentoo) 安装最新发布版本
+++++++++++++++++++++++++++++++++++++

.. code-block:: bash

    $ emerge -av app-admin/ansible

要安装最新版本，你可能需要在执行 emerge 之前，先做如下操作 (unmsk ansible)

.. code-block:: bash

    $ echo 'app-admin/ansible' >> /etc/portage/package.accept_keywords

.. note::

若在 Gentoo 托管节点中，已经安装了 Python 3 并将之作为默认的 Python slot (这也是默认设置)，则你必须在 组变量 或 inventory 变量中设置如下变量   
``ansible_python_interpreter = /usr/bin/python2`` 

通过 pkg (FreeBSD) 安装最新发布版本
+++++++++++++++++++++++++++++++++++

.. code-block:: bash

    $ sudo pkg install ansible

你或许想从 ports 中安装:

.. code-block:: bash

    $ sudo make -C /usr/ports/sysutils/ansible install

.. _on_macos:

在 Mac OSX 上安装最新发布版本
+++++++++++++++++++++++++++++++++++++++

在 Mac 上安装 Ansible，最好是通过 pip 安装，在 `通过 Pip 安装最新发布版本`_ 小节介绍。


.. _from_pkgutil:

通过 OpenCSW 安装最新发布版本 (Solaris)
+++++++++++++++++++++++++++++++++++++

在 Solaris 上安装 Ansible: `SysV package from OpenCSW <https://www.opencsw.org/packages/ansible/>`_.

.. code-block:: bash

    # pkgadd -d http://get.opencsw.org/now
    # /opt/csw/bin/pkgutil -i ansible

.. _from_pacman:

通过 Pacman 安装最新发布版本(Arch Linux)
+++++++++++++++++++++++++++++++++++++++

Ansible 已经放入了 Community repository::

    $ pacman -S ansible

The AUR has a PKGBUILD for pulling directly from Github called `ansible-git <https://aur.archlinux.org/packages/ansible-git>`_.

Also see the `Ansible <https://wiki.archlinux.org/index.php/Ansible>`_ page on the ArchWiki.

.. note::

如果在 Arch Linux 上已经安装了 Python 3，并设置为默认的 Python slot，你必须在 组变量 或 inventory 变量中设置如下变量:
``ansible_python_interpreter = /usr/bin/python2``

.. _from_pip:

通过 Pip 安装最新发布版本
+++++++++++++++++++++++++

Ansible 可通过 "pip" 安装 (安装和管理 Python 包的工具)，若你还没有安装 pip，可执行如下命令安装::

   $ sudo easy_install pip

然后安装 Ansible::

   $ sudo pip install ansible

如果你是在 OS X Mavericks 上安装，编译器可能或告警或报错，可通过如下设置避免这种情况::

   $ sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments pip install ansible

使用 virtualenv 的读者可通过 virtualenv 安装 Ansible，然而我们建议不用这样做，直接在全局安装 Ansible。不要使用 easy_install 直接安装 Ansible.

.. _tagged_releases:

发行版的 Tarball
+++++++++++++++++++++++++++

不想通过 git checkout 创建 Ansible 的软件包？在这里可获取 Tarball `Ansible downloads <http://releases.ansible.com/ansible>`_ 

各种版本的 Ansible 在这里做了版本标注 `git repository <https://github.com/ansible/ansible/releases>`_ 

.. seealso::

   :doc:`intro_adhoc`
       Examples of basic commands
   :doc:`playbooks`
       Learning ansible's configuration management language
   `Mailing List <http://groups.google.com/group/ansible-project>`_
       Questions? Help? Ideas?  Stop by the list on Google Groups
   `irc.freenode.net <http://irc.freenode.net>`_
       #ansible IRC chat channel
