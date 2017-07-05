package entity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * JDBC支持的Java日期类型是java.sql包下的类型：
 * 	Date 年月日
 * 	Time 时分秒
 * 	Timestamp 年月日时分秒
 * 他们都继承于java.util.Date
 */
public class Cost implements Serializable {

	private Integer costId;
	private String name;
	//基本时长
	private Integer baseDuration;
	//基本费用
	private Double baseCost;
	//单位费用
	private Double unitCost;
	//状态：0-开通；1-暂停；
	private String status;
	//描述
	private String descr;
	//创建时间
	private Timestamp creatime;
	//开通时间
	private Timestamp startime;
	//资费类型：1-包月；2-套餐；3-计时；
	private String costType;
	
	public Integer getCostId() {
		return costId;
	}
	public void setCostId(Integer costId) {
		this.costId = costId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getBaseDuration() {
		return baseDuration;
	}
	public void setBaseDuration(Integer baseDuration) {
		this.baseDuration = baseDuration;
	}
	public Double getBaseCost() {
		return baseCost;
	}
	public void setBaseCost(Double baseCost) {
		this.baseCost = baseCost;
	}
	public Double getUnitCost() {
		return unitCost;
	}
	public void setUnitCost(Double unitCost) {
		this.unitCost = unitCost;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public Timestamp getCreatime() {
		return creatime;
	}
	public void setCreatime(Timestamp creatime) {
		this.creatime = creatime;
	}
	public Timestamp getStartime() {
		return startime;
	}
	public void setStartime(Timestamp startime) {
		this.startime = startime;
	}
	public String getCostType() {
		return costType;
	}
	public void setCostType(String costType) {
		this.costType = costType;
	}
	
}





