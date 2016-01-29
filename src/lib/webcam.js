import getUserMedia from 'getusermedia';

export function closeStream(stream) {
    stream.getVideoTracks()[0].stop();
    return !stream.active;
}

export function createThumbnail(image) {
    const el = document.createElement('div');
    el.style.backgroundPosition = 'center';
    el.style.backgroundRepeat = 'no-repeat';
    el.style.backgroundImage = `url(${image})`;
    el.style.height = 150;
    el.style.width = 150;
    return el;
}

export function createVideo(stream) {
    return URL.createObjectURL(stream);
}

export function requestCamera() {
    return new Promise((resolve, reject) => {
        getUserMedia({ video: true }, (err, stream) => {
            if (err) reject(err);
            else resolve(stream);
        });
    });
}
