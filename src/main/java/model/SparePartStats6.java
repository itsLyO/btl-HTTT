package model;

public class SparePartStats6 extends SparePart6 {
    private static final long serialVersionUID = 1L;

    private int totalUsedQuantity;
    private float totalRevenue;

    public SparePartStats6() {
        super();
    }

    public SparePartStats6(int id, String name, String manufacturer, String unit, float unitPrice, float importPriceRef, int stockQuantity, String desc, int totalUsedQuantity, float totalRevenue) {
        super(id, name, manufacturer, unit, unitPrice, importPriceRef, stockQuantity, desc);
        this.totalUsedQuantity = totalUsedQuantity;
        this.totalRevenue = totalRevenue;
    }

    public int getTotalUsedQuantity() {
        return totalUsedQuantity;
    }

    public void setTotalUsedQuantity(int totalUsedQuantity) {
        this.totalUsedQuantity = totalUsedQuantity;
    }

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
