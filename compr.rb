#!/usr/bin/env ruby

module MP3
	def cut_silence(source, destination)
	end

	def time_stretch(source, destination)
	end

	def pitch(source, destination)
	end
end

def main
	#if ARGV[0][0] == '/'
	#	arg = ARGV[0]
	#else
	#	arg = File.join(Dir.pwd, ARGV[0])
	#end
	arg = ARGV[0]

	if File.directory?(arg)
		process_dir(arg)
	elsif File.file?(arg)
		process_file(arg)
	end
end

def process_dir(dir)
	files = Dir.glob(File.join(dir, '*.mp3'))
	files.each do |file|
		process_file(file)
	end
end

def process_file(file)
	#p File.extname(file)
	unless File.extname(file) == '.mp3'
		p "Not mp3 file: #{file}"
		return
	end

	if File.file?(compressed(file))
		p "Already compressed: #{file}"
		return
	end

	compressed_dir = File.join(File.dirname(file), 'compressed')
	Dir.mkdir(compressed_dir) unless File.directory?(compressed_dir)

	`sox -S '#{file}' '#{silenced(file)}' silence 1 0.1 0.5% -1 0.1 0.5%`
	`sox -S '#{silenced(file)}' '#{stretched(file)}' tempo 1.2`
	`sox -S '#{stretched(file)}' '#{compressed(file)}' speed 1.2`

	File.delete(silenced(file))
	File.delete(stretched(file))
end

def format_filename(file, suffix)
	File.join(File.dirname(file), 'compressed', "#{File.basename(file, '.mp3')}-#{suffix}.mp3")
end

def silenced(file)
	format_filename(file, 'silenced')
	#File.join(File.dirname(file), "#{File.basename(file, '.mp3')}-silenced.mp3")
end

def stretched(file)
	format_filename(file, 'stretched')
	#File.join(File.dirname(file), "#{File.basename(file, '.mp3')}-stretched.mp3")
end

def compressed(file)
	format_filename(file, 'compressed')
	#File.join(File.dirname(file), "#{File.basename(file, '.mp3')}-compressed.mp3")
end


main
