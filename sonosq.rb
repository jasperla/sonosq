#!/usr/bin/env ruby
#
# Copy Sonos queues between speakers

require 'thor'
require 'sonos'

class SonosCLI < Thor
  desc 'append FROM TO', 'append queue'
  def append(from, to)
    SonosQ.new.queue_mgr('append', from, to)
  end

  desc 'replace FROM to', 'replace queue'
  def replace(from, to)
    SonosQ.new.queue_mgr('replace', from, to)
  end
end

class SonosQ
  def initialize
    system = Sonos::System.new
    @speakers = system.speakers
  end

  # Retrieve the Sonos::Device::Speaker from the system
  def get_speaker(speaker)
    @speakers.select { |s| s.name.downcase == speaker.downcase }.shift
  end

  def get_queue(speaker)
    speaker.queue.fetch(:items)
  end

  def add_to_queue
    retried = 0

    begin
      yield
    rescue
      if retried < 3
        retried += 1
        retry
      else
        # Just give up on this track and skip it.
        retried = 0
      end
    end
  end

  def queue_mgr(action, from, to)
    to_speaker = self.get_speaker(to)
    from_speaker = self.get_speaker(from)

    to_speaker.clear_queue if action == 'replace'

    self.get_queue(from_speaker).each do |t|
      id = t.fetch(:id)

      # XXX: Add support for non-Spotify (local and Rdio) tracks.
      if id =~ /x-sonos-spotify/
        sonos_id = id.match(/^.*track%3a(.*?)\?sid/)[1]

        add_to_queue { to_speaker.add_spotify_to_queue({:id => sonos_id, :region => 'NL'}) }
      end
    end
  end
end

SonosCLI.start(ARGV)
