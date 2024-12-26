const { spotifyApi } = require("./auth");

const searchTracks = async (query) => {
    try {
        const response = await spotifyApi.searchTracks(query);
        return response.body.tracks.items.map((track) => ({
            id: track.id,
            name: track.name,
            album: track.album.name,
            artist: track.artists[0].name,
            image: track.album.images[0].url,
            uri: track.uri,
        }))
    } catch (error) {
        throw new Error("Failed to search tracks: " + error);
    }
};

MediaSourceHandle.exports = { searchTracks };