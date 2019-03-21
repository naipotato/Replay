if [ ! -d "build" ]; then
    meson build --prefix /usr
fi

ninja -C build
