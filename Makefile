IMAGELIST= image_list

OUTPUT= unsplash-backgrounds.xml

OBJ= $(notdir $(wildcard unsplash/*))

.PHONY: all

all: header $(OBJ) footer
	@echo "Generated file: $(OUTPUT)"

download:
	mkdir -pv unsplash
	wget -i $(IMAGELIST) --content-disposition -P unsplash

header:
	@echo -e '<?xml version="1.0"?>\n<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">\n<wallpapers>' > $(OUTPUT)

$(OBJ):
	@echo -e '  <wallpaper deleted="false">' >> $(OUTPUT)
	@echo -e '    <name>$@</name>' >> $(OUTPUT)
	@echo -e '    <filename>/usr/share/backgrounds/unsplash/$@</filename>' >> $(OUTPUT)
	@echo -e '    <options>zoom</options>' >> $(OUTPUT)
	@echo -e '    <pcolor>#ffffff</pcolor>' >> $(OUTPUT)
	@echo -e '    <scolor>#000000</scolor>' >> $(OUTPUT)
	@echo -e '  </wallpaper>' >> $(OUTPUT)

footer:
	@echo '</wallpapers>' >> $(OUTPUT)

install:
	cp -r unsplash /usr/share/backgrounds/
	cp unsplash-backgrounds.xml /usr/share/gnome-background-properties/

uninstall:
	rm -r /usr/share/backgrounds/unsplash
	rm -r /usr/share/gnome-background-properties/unsplash-backgrounds.xml

clean:
	rm -rf unsplash unsplash-backgrounds.xml

