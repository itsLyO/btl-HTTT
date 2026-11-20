package model;

public class ServiceStats6 extends Service6 {
    private static final long serialVersionUID = 1L;

    private int totalTimes;
    private float totalRevenue;

    public ServiceStats6() {
        super();
    }

    public ServiceStats6(int id, String name, float price, int estDuration, String desc, String warrantyNote, int totalTimes, float totalRevenue) {
        super(id, name, price, estDuration, desc, warrantyNote);
        this.totalTimes = totalTimes;
        this.totalRevenue = totalRevenue;
    }

    public int getTotalTimes() {
        return totalTimes;
    }

    public void setTotalTimes(int totalTimes) {
        this.totalTimes = totalTimes;
    }

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
