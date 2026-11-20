package model;

public class SupplierStats6 extends Supplier6 {
    private static final long serialVersionUID = 1L;

    private int totalImportBills;
    private float totalExpense;

    public SupplierStats6() {
        super();
    }

    public SupplierStats6(int id, String name, String taxCode, String email, String tel, String desc, int totalImportBills, float totalExpense) {
        super(id, name, taxCode, email, tel, desc);
        this.totalImportBills = totalImportBills;
        this.totalExpense = totalExpense;
    }

    public int getTotalImportBills() {
        return totalImportBills;
    }

    public void setTotalImportBills(int totalImportBills) {
        this.totalImportBills = totalImportBills;
    }

    public float getTotalExpense() {
        return totalExpense;
    }

    public void setTotalExpense(float totalExpense) {
        this.totalExpense = totalExpense;
    }
}
