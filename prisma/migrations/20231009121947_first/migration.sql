-- CreateEnum
CREATE TYPE "DiscountAllocationTypes" AS ENUM ('TotalAmount', 'ItemSpecific');

-- CreateEnum
CREATE TYPE "PriceListType" AS ENUM ('Sale', 'Override');

-- CreateTable
CREATE TABLE "Products" (
    "id" SERIAL NOT NULL,
    "type_id" INTEGER NOT NULL,
    "collection_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "subtitle" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "handle" TEXT NOT NULL,
    "is_dicountable" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Collection" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Collection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tags" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductTags" (
    "id" SERIAL NOT NULL,
    "tag_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,

    CONSTRAINT "ProductTags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductOptions" (
    "id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "ProductOptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductOptionVariations" (
    "id" SERIAL NOT NULL,
    "product_option_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "ProductOptionVariations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductVariants" (
    "id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "customTitle" TEXT NOT NULL,
    "material" TEXT NOT NULL,
    "manage_inventory" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProductVariants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductVariationOptionDetails" (
    "id" SERIAL NOT NULL,
    "product_variant_id" INTEGER NOT NULL,
    "product_option_variation_id" INTEGER NOT NULL,

    CONSTRAINT "ProductVariationOptionDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductMedia" (
    "id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "product_variant_id" INTEGER NOT NULL,
    "filename" TEXT NOT NULL,
    "mime_type" TEXT NOT NULL,
    "size" DOUBLE PRECISION NOT NULL,
    "file_path" TEXT NOT NULL,
    "is_thumbnail" BOOLEAN NOT NULL,

    CONSTRAINT "ProductMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BasePricing" (
    "id" SERIAL NOT NULL,
    "product_variant_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "is_deafult" BOOLEAN NOT NULL,

    CONSTRAINT "BasePricing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShippingDetails" (
    "id" SERIAL NOT NULL,
    "product_variant_id" INTEGER NOT NULL,
    "height" DOUBLE PRECISION NOT NULL,
    "width" DOUBLE PRECISION NOT NULL,
    "length" DOUBLE PRECISION NOT NULL,
    "mid_code" TEXT NOT NULL,
    "hs_code" TEXT NOT NULL,
    "country_of_origin" TEXT NOT NULL,

    CONSTRAINT "ShippingDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Inventory" (
    "id" SERIAL NOT NULL,
    "product_variant_id" INTEGER NOT NULL,
    "stock_keeping_unit" TEXT NOT NULL,
    "barcodeEAN" TEXT NOT NULL,
    "barcodeUPC" TEXT NOT NULL,
    "barcode" TEXT NOT NULL,
    "quantity_in_stock" INTEGER NOT NULL,
    "material" TEXT NOT NULL,

    CONSTRAINT "Inventory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingList" (
    "id" SERIAL NOT NULL,
    "type" "PriceListType" NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "has_start_date" BOOLEAN NOT NULL,
    "has_stop_date" BOOLEAN NOT NULL,
    "start_date" DATE NOT NULL,
    "stop_date" DATE NOT NULL,
    "has_start_time" BOOLEAN NOT NULL,
    "has_stop_time" BOOLEAN NOT NULL,
    "start_time" TIME NOT NULL,
    "stop_time" TIME NOT NULL,
    "time_zone" TEXT NOT NULL,

    CONSTRAINT "PricingList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingListProductVariants" (
    "id" SERIAL NOT NULL,
    "pricing_list_id" INTEGER NOT NULL,
    "product_variant_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "PricingListProductVariants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscountTypes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "allocation_type" "DiscountAllocationTypes" NOT NULL,

    CONSTRAINT "DiscountTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Discounts" (
    "id" SERIAL NOT NULL,
    "discount_type_id" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "description" TEXT NOT NULL,
    "has_start_date" BOOLEAN NOT NULL,
    "has_stop_date" BOOLEAN NOT NULL,
    "start_date" DATE NOT NULL,
    "stop_date" DATE NOT NULL,
    "has_start_time" BOOLEAN NOT NULL,
    "has_stop_time" BOOLEAN NOT NULL,
    "start_time" TIME NOT NULL,
    "end_time" TIME NOT NULL,
    "time_zone" TEXT NOT NULL,
    "has_redemption_limit" BOOLEAN NOT NULL,
    "redemption_limit" INTEGER NOT NULL,
    "has_redemption_limit_per_customer" BOOLEAN NOT NULL,
    "redemption_limit_per_customer" INTEGER NOT NULL,
    "has_conditions" BOOLEAN NOT NULL,

    CONSTRAINT "Discounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscountConditionsProductsTypes" (
    "id" SERIAL NOT NULL,
    "discount_id" INTEGER NOT NULL,
    "product_type_id" INTEGER NOT NULL,
    "inclusion_flag" BOOLEAN NOT NULL,

    CONSTRAINT "DiscountConditionsProductsTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscountConditionsProducts" (
    "id" SERIAL NOT NULL,
    "discount_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "inclusion_flag" BOOLEAN NOT NULL,

    CONSTRAINT "DiscountConditionsProducts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscountConditionsProductsCollections" (
    "id" SERIAL NOT NULL,
    "discount_id" INTEGER NOT NULL,
    "product_collection_id" INTEGER NOT NULL,
    "inclusion_flag" BOOLEAN NOT NULL,

    CONSTRAINT "DiscountConditionsProductsCollections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscountConditionsProductsTags" (
    "id" SERIAL NOT NULL,
    "discount_id" INTEGER NOT NULL,
    "product_tag_id" INTEGER NOT NULL,
    "inclusion_flag" BOOLEAN NOT NULL,

    CONSTRAINT "DiscountConditionsProductsTags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscountConditionsCustomerGroups" (
    "id" SERIAL NOT NULL,
    "discount_id" INTEGER NOT NULL,
    "customer_group_id" INTEGER NOT NULL,
    "inclusion_flag" BOOLEAN NOT NULL,

    CONSTRAINT "DiscountConditionsCustomerGroups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Customers" (
    "id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Customers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShippingAddresses" (
    "id" SERIAL NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "ShippingAddresses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Groups" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GroupMembers" (
    "id" SERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GroupMembers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Orders" (
    "id" SERIAL NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "shipping_address_id" INTEGER NOT NULL,
    "total_amount" DOUBLE PRECISION NOT NULL,
    "fulfillment" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderItems" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "product_variant_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "OrderItems_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Currency" (
    "id" SERIAL NOT NULL,
    "currency_name" TEXT NOT NULL,
    "currency_code" TEXT NOT NULL,

    CONSTRAINT "Currency_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_collection_id_fkey" FOREIGN KEY ("collection_id") REFERENCES "Collection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductTags" ADD CONSTRAINT "ProductTags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "Tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductTags" ADD CONSTRAINT "ProductTags_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOptions" ADD CONSTRAINT "ProductOptions_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOptionVariations" ADD CONSTRAINT "ProductOptionVariations_product_option_id_fkey" FOREIGN KEY ("product_option_id") REFERENCES "ProductOptions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariants" ADD CONSTRAINT "ProductVariants_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariationOptionDetails" ADD CONSTRAINT "ProductVariationOptionDetails_product_variant_id_fkey" FOREIGN KEY ("product_variant_id") REFERENCES "ProductVariants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductVariationOptionDetails" ADD CONSTRAINT "ProductVariationOptionDetails_product_option_variation_id_fkey" FOREIGN KEY ("product_option_variation_id") REFERENCES "ProductOptionVariations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductMedia" ADD CONSTRAINT "ProductMedia_product_variant_id_fkey" FOREIGN KEY ("product_variant_id") REFERENCES "ProductVariants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BasePricing" ADD CONSTRAINT "BasePricing_product_variant_id_fkey" FOREIGN KEY ("product_variant_id") REFERENCES "ProductVariants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BasePricing" ADD CONSTRAINT "BasePricing_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "Currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShippingDetails" ADD CONSTRAINT "ShippingDetails_product_variant_id_fkey" FOREIGN KEY ("product_variant_id") REFERENCES "ProductVariants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inventory" ADD CONSTRAINT "Inventory_product_variant_id_fkey" FOREIGN KEY ("product_variant_id") REFERENCES "ProductVariants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingListProductVariants" ADD CONSTRAINT "PricingListProductVariants_pricing_list_id_fkey" FOREIGN KEY ("pricing_list_id") REFERENCES "PricingList"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingListProductVariants" ADD CONSTRAINT "PricingListProductVariants_product_variant_id_fkey" FOREIGN KEY ("product_variant_id") REFERENCES "ProductVariants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingListProductVariants" ADD CONSTRAINT "PricingListProductVariants_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "Currency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discounts" ADD CONSTRAINT "Discounts_discount_type_id_fkey" FOREIGN KEY ("discount_type_id") REFERENCES "DiscountTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProductsTypes" ADD CONSTRAINT "DiscountConditionsProductsTypes_discount_id_fkey" FOREIGN KEY ("discount_id") REFERENCES "Discounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProductsTypes" ADD CONSTRAINT "DiscountConditionsProductsTypes_product_type_id_fkey" FOREIGN KEY ("product_type_id") REFERENCES "Types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProducts" ADD CONSTRAINT "DiscountConditionsProducts_discount_id_fkey" FOREIGN KEY ("discount_id") REFERENCES "Discounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProducts" ADD CONSTRAINT "DiscountConditionsProducts_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProductsCollections" ADD CONSTRAINT "DiscountConditionsProductsCollections_discount_id_fkey" FOREIGN KEY ("discount_id") REFERENCES "Discounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProductsCollections" ADD CONSTRAINT "DiscountConditionsProductsCollections_product_collection_i_fkey" FOREIGN KEY ("product_collection_id") REFERENCES "Collection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProductsTags" ADD CONSTRAINT "DiscountConditionsProductsTags_discount_id_fkey" FOREIGN KEY ("discount_id") REFERENCES "Discounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsProductsTags" ADD CONSTRAINT "DiscountConditionsProductsTags_product_tag_id_fkey" FOREIGN KEY ("product_tag_id") REFERENCES "Tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsCustomerGroups" ADD CONSTRAINT "DiscountConditionsCustomerGroups_discount_id_fkey" FOREIGN KEY ("discount_id") REFERENCES "Discounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscountConditionsCustomerGroups" ADD CONSTRAINT "DiscountConditionsCustomerGroups_customer_group_id_fkey" FOREIGN KEY ("customer_group_id") REFERENCES "Groups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShippingAddresses" ADD CONSTRAINT "ShippingAddresses_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMembers" ADD CONSTRAINT "GroupMembers_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "Groups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMembers" ADD CONSTRAINT "GroupMembers_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "Customers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_shipping_address_id_fkey" FOREIGN KEY ("shipping_address_id") REFERENCES "ShippingAddresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItems" ADD CONSTRAINT "OrderItems_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItems" ADD CONSTRAINT "OrderItems_product_variant_id_fkey" FOREIGN KEY ("product_variant_id") REFERENCES "ProductVariants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
