---
layout: post
title: The Focusrite Scarlett 2i2 & Linux
---

![Focusrite Scarlett 2i2](/images/2012-03-04-scarlett.jpg)

I recently purchased a [Focusrite Scarlett 2i2][Scarlett] audio interface with
the intention of using it with Mac&nbsp;OS&nbsp;X, Windows and, primarily,
Linux. In the interest of increasing the signal-to-noise ratio of the Internet,
here follows a brief report of the Scarlett–Linux experience.

Because audio interfaces don't always get along with Linux, I did some research
prior to making my purchase; however, up-to-date information about audio
devices and Linux is surprisingly scarce on the web. All I was able to find
was a [post on the Ardour forum][forum-post] saying that someone had been able
to use the Scarlett 2i2 with Ubuntu 11.1, but not providing much detail about
how it was set up. I emailed the Focusrite sales department and was told that
the Scarlett 2i2, being a USB audio class compliant device, *should work* with
Linux, but that they hadn't tested it and couldn't make any promises.

I can confirm that, after a bit of configuration, it does work with my 64-bit
[Arch Linux][Arch] system using [ALSA][ALSA]. The configuration in question is
simple, but took me some time and googling to figure out. There exists some
sort of conflict between the Intel audio module and USB audio; I don't know
what exactly the problem is, but as I have no intention of using the integrated
Intel soundcard, the fix was to simply disable it:

    #
    # /etc/modprobe.d/modprobe.conf
    #

    # disable integrated soundcard
    blacklist snd_hda_intel

Having done this, the Scarlett works flawlessly. It is worth noting that ALSA's
USB mixer does not offer any controls, so I'm using the Scarlett's physical
volume control only. Using [JACK][JACK] adds software control, but Spotify
doesn't currently work with JACK, so you'll have to use straight ALSA if you
want to use Spotify. (You can, of course, run JACK temporarily if you need it
for some specific purpose.)

**2012-12-14 edit:**

After writing this post, I received a nice email from Holger Marzen telling
me that I can, in fact, use JACK in conjunction with ALSA by redirecting the
I/O of ALSA clients to JACK. This is achieved by adding the following to your
`$HOME/.asoundrc` file (as seen in [Holger's how-to][Holger-how-to]):

    pcm.!default {
        type plug
        slave.pcm "jack"
    }

    pcm.jack {
        type jack
        playback_ports {
            0 system:playback_1
            1 system:playback_2
        }
        capture_ports {
            0 system:capture_1
            1 system:capture_2
        }
    }

After adding such a file, I was able to use Spotify while JACK was running.
In fact, Spotify now supports JACK so such a file is not necessary; however,
you'll still need a `.asoundrc` like the one above if you have other ALSA
clients you want to coexist with JACK.

So there you have it: ALSA and JACK may live together in peace and harmony.

**End of edit.**

I haven't done any serious recording with the Scarlett at this point, so I
won't do a full-on review of the device itself. Suffice it to say that the
(recorded) audio quality sounds good to me, and I've had no problems with
everyday playback, which is what I've primarily used it for. The box itself
seems solid, and the Focusrite salesperson I corresponded with was helpful and
replied quickly, so I have no reservations in recommending the Scarlett 2i2 to
others.

[Scarlett]: http://focusrite.com/products/audio_interfaces/scarlett_2i2/ "Focusrite Scarlett 2i2"
[forum-post]: http://ardour.org/node/4709 "Ardour forum"
[Arch]: http://www.archlinux.org/ "Arch Linux"
[ALSA]: http://www.alsa-project.org/ "ALSA"
[JACK]: http://jackaudio.org/ "JACK"
[Holger-how-to]: http://www.marzen.de/Holger/pulseaudio_and_jack "Holger's JACK how-to"
