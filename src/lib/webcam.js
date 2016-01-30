import getUserMedia from 'getusermedia';

export function closeStream(stream) {
    stream.getVideoTracks()[0].stop();
    return !stream.active;
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
