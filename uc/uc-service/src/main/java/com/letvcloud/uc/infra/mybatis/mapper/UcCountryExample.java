package com.letvcloud.uc.infra.mybatis.mapper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UcCountryExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    protected List<Criteria> oredCriteria;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    protected int[] limit = new int[] {-1, -1};

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public UcCountryExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public void setLimitValue1(int val) {
        this.limit[0] = val;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public void setLimitValue2(int val) {
        this.limit[1] = val;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public int getLimitValue1() {
        return this.limit[0];
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public int getLimitValue2() {
        return this.limit[1];
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Long value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Long value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Long value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Long value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Long value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Long value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Long> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Long> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Long value1, Long value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Long value1, Long value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andCountrynameIsNull() {
            addCriterion("countryName is null");
            return (Criteria) this;
        }

        public Criteria andCountrynameIsNotNull() {
            addCriterion("countryName is not null");
            return (Criteria) this;
        }

        public Criteria andCountrynameEqualTo(String value) {
            addCriterion("countryName =", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameNotEqualTo(String value) {
            addCriterion("countryName <>", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameGreaterThan(String value) {
            addCriterion("countryName >", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameGreaterThanOrEqualTo(String value) {
            addCriterion("countryName >=", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameLessThan(String value) {
            addCriterion("countryName <", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameLessThanOrEqualTo(String value) {
            addCriterion("countryName <=", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameLike(String value) {
            addCriterion("countryName like", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameNotLike(String value) {
            addCriterion("countryName not like", value, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameIn(List<String> values) {
            addCriterion("countryName in", values, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameNotIn(List<String> values) {
            addCriterion("countryName not in", values, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameBetween(String value1, String value2) {
            addCriterion("countryName between", value1, value2, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrynameNotBetween(String value1, String value2) {
            addCriterion("countryName not between", value1, value2, "countryname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameIsNull() {
            addCriterion("countryDomainName is null");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameIsNotNull() {
            addCriterion("countryDomainName is not null");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameEqualTo(String value) {
            addCriterion("countryDomainName =", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameNotEqualTo(String value) {
            addCriterion("countryDomainName <>", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameGreaterThan(String value) {
            addCriterion("countryDomainName >", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameGreaterThanOrEqualTo(String value) {
            addCriterion("countryDomainName >=", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameLessThan(String value) {
            addCriterion("countryDomainName <", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameLessThanOrEqualTo(String value) {
            addCriterion("countryDomainName <=", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameLike(String value) {
            addCriterion("countryDomainName like", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameNotLike(String value) {
            addCriterion("countryDomainName not like", value, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameIn(List<String> values) {
            addCriterion("countryDomainName in", values, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameNotIn(List<String> values) {
            addCriterion("countryDomainName not in", values, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameBetween(String value1, String value2) {
            addCriterion("countryDomainName between", value1, value2, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountrydomainnameNotBetween(String value1, String value2) {
            addCriterion("countryDomainName not between", value1, value2, "countrydomainname");
            return (Criteria) this;
        }

        public Criteria andCountryareanumIsNull() {
            addCriterion("countryAreaNum is null");
            return (Criteria) this;
        }

        public Criteria andCountryareanumIsNotNull() {
            addCriterion("countryAreaNum is not null");
            return (Criteria) this;
        }

        public Criteria andCountryareanumEqualTo(String value) {
            addCriterion("countryAreaNum =", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumNotEqualTo(String value) {
            addCriterion("countryAreaNum <>", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumGreaterThan(String value) {
            addCriterion("countryAreaNum >", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumGreaterThanOrEqualTo(String value) {
            addCriterion("countryAreaNum >=", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumLessThan(String value) {
            addCriterion("countryAreaNum <", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumLessThanOrEqualTo(String value) {
            addCriterion("countryAreaNum <=", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumLike(String value) {
            addCriterion("countryAreaNum like", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumNotLike(String value) {
            addCriterion("countryAreaNum not like", value, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumIn(List<String> values) {
            addCriterion("countryAreaNum in", values, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumNotIn(List<String> values) {
            addCriterion("countryAreaNum not in", values, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumBetween(String value1, String value2) {
            addCriterion("countryAreaNum between", value1, value2, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCountryareanumNotBetween(String value1, String value2) {
            addCriterion("countryAreaNum not between", value1, value2, "countryareanum");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeIsNull() {
            addCriterion("createdTime is null");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeIsNotNull() {
            addCriterion("createdTime is not null");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeEqualTo(Date value) {
            addCriterion("createdTime =", value, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeNotEqualTo(Date value) {
            addCriterion("createdTime <>", value, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeGreaterThan(Date value) {
            addCriterion("createdTime >", value, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeGreaterThanOrEqualTo(Date value) {
            addCriterion("createdTime >=", value, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeLessThan(Date value) {
            addCriterion("createdTime <", value, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeLessThanOrEqualTo(Date value) {
            addCriterion("createdTime <=", value, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeIn(List<Date> values) {
            addCriterion("createdTime in", values, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeNotIn(List<Date> values) {
            addCriterion("createdTime not in", values, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeBetween(Date value1, Date value2) {
            addCriterion("createdTime between", value1, value2, "createdtime");
            return (Criteria) this;
        }

        public Criteria andCreatedtimeNotBetween(Date value1, Date value2) {
            addCriterion("createdTime not between", value1, value2, "createdtime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeIsNull() {
            addCriterion("lastUpdateTime is null");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeIsNotNull() {
            addCriterion("lastUpdateTime is not null");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeEqualTo(Date value) {
            addCriterion("lastUpdateTime =", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeNotEqualTo(Date value) {
            addCriterion("lastUpdateTime <>", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeGreaterThan(Date value) {
            addCriterion("lastUpdateTime >", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeGreaterThanOrEqualTo(Date value) {
            addCriterion("lastUpdateTime >=", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeLessThan(Date value) {
            addCriterion("lastUpdateTime <", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeLessThanOrEqualTo(Date value) {
            addCriterion("lastUpdateTime <=", value, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeIn(List<Date> values) {
            addCriterion("lastUpdateTime in", values, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeNotIn(List<Date> values) {
            addCriterion("lastUpdateTime not in", values, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeBetween(Date value1, Date value2) {
            addCriterion("lastUpdateTime between", value1, value2, "lastupdatetime");
            return (Criteria) this;
        }

        public Criteria andLastupdatetimeNotBetween(Date value1, Date value2) {
            addCriterion("lastUpdateTime not between", value1, value2, "lastupdatetime");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table uc_country
     *
     * @mbggenerated do_not_delete_during_merge Thu Aug 27 16:59:46 CST 2015
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table uc_country
     *
     * @mbggenerated Thu Aug 27 16:59:46 CST 2015
     */
    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}