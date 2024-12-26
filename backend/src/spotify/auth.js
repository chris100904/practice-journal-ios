const SpotifyWebApi = require("spotify-web-api-node");
const spotifyConfig = require("../config/spotify").default;

const spotifyApi = new SpotifyWebApi({
  clientId: spotifyConfig.client_id,
  clientSecret: spotifyConfig.client_secret,
  redirectUri: spotifyConfig.redirect_uri,
});

const getAuthURL = () => {
  const scopes = ["user-read-private", "playlist-read-private", "playlist-modify-public", "playlist-modify-private"];

  return spotifyApi.createAuthorizeURL(scopes);
};

const handleCallback = async (code) => {
  try {
    const data = await spotifyApi.authorizationCodeGrant(code);
    return {
      accessToken: data.body.access_token,
      refreshToken: data.body.refresh_token,
      expiresIn: data.body.expires_in,
    };
  } catch (error) {
    throw new Error("Failed to get access token: " + error);
  }
};

module.exports = {
  spotifyApi,
  getAuthURL,
  handleCallback,
};
