package jsontest;

public class MovieTime {
    String movieTitle;
    String hallType;
    String hallName;
    String time;
    String availableSeats;

    public MovieTime() {
    }

    public MovieTime(String movieTitle, String hallType, String hallName, String time, String availableSeats) {
        this.movieTitle = movieTitle;
        this.hallType = hallType;
        this.hallName = hallName;
        this.time = time;
        this.availableSeats = availableSeats;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getHallType() {
        return hallType;
    }

    public void setHallType(String hallType) {
        this.hallType = hallType;
    }

    public String getHallName() {
        return hallName;
    }

    public void setHallName(String hallName) {
        this.hallName = hallName;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(String availableSeats) {
        this.availableSeats = availableSeats;
    }
}
