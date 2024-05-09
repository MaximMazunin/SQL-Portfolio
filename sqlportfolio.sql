--Dataset: Spotify top 50 songs in 2021
--Source: Kaggle https://www.kaggle.com/datasets/equinxx/spotify-top-50-songs-in-2021
--Queried using: PostgreSQL

SELECT 
	* 
FROM 
	songs

-- What is the average artist popularity?
SELECT 
	artist_name,
	ROUND(AVG(popularity)) AS avarage_popularity
FROM 
	songs
GROUP BY 
	artist_name
ORDER BY 
	avarage_popularity DESC;

--What will be the average danceability of songs for each artist?
SELECT 
	artist_name,
	ROUND(AVG(danceability)::numeric, 3) AS avarage_danceability
FROM 
	songs
GROUP BY 
	artist_name
ORDER BY 
	avarage_danceability DESC;

--Song Energy Analysis
SELECT 
	artist_name,
	ROUND(AVG(energy)::numeric, 3) AS average_energy
FROM 
	songs
GROUP BY 
	artist_name
ORDER BY 
	average_energy DESC;

--Top most popular and danceable songs
SELECT 
	artist_name,
	track_name,
	popularity,
	danceability
FROM 
	songs
ORDER BY 
	popularity DESC, 
	danceability DESC;

--Average tempo and song length
SELECT
    artist_name,
    track_name,
    ROUND(AVG(tempo)::numeric, 3) AS average_tempo,
	--convert ms to min
    ROUND(AVG(duration_ms) / 60000.0, 2) AS average_duration_minutes
FROM 
    songs
GROUP BY 
    artist_name,
    track_name;

--Average acoustics of songs by artist
SELECT 
	artist_name,
	track_name,
	ROUND(AVG(acousticness)::numeric, 3) AS avarage_acoustic
FROM 
	songs
GROUP BY 
	artist_name,
	track_name
ORDER BY 
	avarage_acoustic DESC;

--Comparison of popularity and acoustics
SELECT
	track_name,
	popularity, 
	acousticness
FROM 
	songs
ORDER BY 
	acousticness DESC,
	popularity DESC;

-- Average energy of songs by key and its impact on artist popularity
SELECT 
    key,
    ROUND(AVG(energy)::numeric, 3) AS average_energy,
    artist_name,
    ROUND(AVG(popularity)) AS average_popularity
FROM 
    songs
GROUP BY 
    key,
    artist_name
ORDER BY 
    key,
    average_energy DESC;

--In what key is each track from the dataset?
--Using pitch-class integer notation: https://smbutterfield.github.io/ibmt17-18/22-intro-to-non-diatonic-materials/b2-tx-pcintnotation.html
SELECT 
    track_name,
    key,
    CASE 
        WHEN key = 0 THEN 'C'
        WHEN key = 1 THEN 'C#/Db'
        WHEN key = 2 THEN 'D'
        WHEN key = 3 THEN 'D#/Eb'
        WHEN key = 4 THEN 'E'
        WHEN key = 5 THEN 'F'
        WHEN key = 6 THEN 'F#/Gb'
        WHEN key = 7 THEN 'G'
        WHEN key = 8 THEN 'G#/Ab'
        WHEN key = 9 THEN 'A'
        WHEN key = 10 THEN 'A#/Bb'
        WHEN key = 11 THEN 'B'
        ELSE 'Unknown'
    END AS key_name
FROM 
    songs
ORDER BY key;