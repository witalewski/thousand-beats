const setBackgroundPhotoFromPexels = async () => {
  const res = await fetch('https://api.pexels.com/v1/curated?per_page=1', {
    headers: {
      Authorization: '563492ad6f91700001000001820eae6aec01466d96a1564b6da71e8a',
    },
  });
  const json = await res.json();
  if (json.photos?.length > 0) {
    const url = json.photos[0].src?.medium ?? '';
    if (url) {
      document
        .querySelector('.app')
        .setAttribute('style', `background-image: url('${url}')`);
    }
  }
};

const setBackgroundPhotoFromUnsplash = async () => {
  const res = await fetch('https://api.unsplash.com/photos/random', {
    headers: {
      Authorization: `Client-ID AfOCIetx2z3JvfLCCxo03UWPs_B0n2K3BV0y_dxRroE`,
    },
  });
  const json = await res.json();
  const url = json.urls?.regular ?? '';
  if (url) {
    document
      .querySelector('.app')
      .setAttribute('style', `background-image: url('${url}')`);
  }
}

export default setBackgroundPhotoFromPexels;
