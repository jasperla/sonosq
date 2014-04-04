SonosQ
======

Neither the Sonos desktop or mobile app allow you to copy the queue from one
group/speaker to another. This is certainly useful if you're listening to a
queue in one room and want to go to another room but turn off the music in the
previous room.
  SonosQ fixes this shortcoming by allowing you slurp the whole queue for a
given speaker and either append it to, or replace the queue for a target speaker.

Usage
-----

To keep the existing queue for `Office` and append the full queue of `LivingRoom`
to it:

    sonosq append LivingRoom Office

To replace the entire queue of `Office` with the queue of `LivingRoom`:

    sonosq replace LivingRoom Office

Caveats
-------

  - Due to the way the queue items are identified support for every type needs
    to be handled separatly. Currently `SonosQ` only handles Spotify files,
	support for locally stored or Rdio entries will be added later.

License
-------

Released under the terms of the MIT license.

Copyright 2014 Jasper Lievisse Adriaanse <jasper@humppa.nl>
