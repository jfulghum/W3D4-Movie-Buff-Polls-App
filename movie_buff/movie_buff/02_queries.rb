def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  # Movie.select('movies.id, title, yr, score')
  # .where('score between 3 and 5 AND yr between 1980 and 1989')

  Movie
  .select('movies.id, title, yr, score')
  .where(score: 3..5, yr: 1980..1989)

end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  # movies = Movie.select('yr')
  #   .group('yr')
  #   .having('max(score) <= 8')
  #
  # movies.map { |m| m.yr }.sort

  Movie
    .group('yr')
    .having('max(score) <= 8')
    .pluck('yr')
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor.select('actors.*')
    .joins(:movies)
    .where('movies.title = ?', title)
    .order('ord')

end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.
  # Note: Directors appear in the 'actors' table.
Actor.select('movies.id, actors.name, movies.title')
.joins(:movies)
.where('actors.id = movies.director_id AND castings.ord = 1')

end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor.select('actors.id, actors.name, COUNT(actors.id) as roles')
    .joins(:movies)
    .where('ord != 1')
    .group('actors.id')
    .order('roles DESC')
    .limit('2')

end
