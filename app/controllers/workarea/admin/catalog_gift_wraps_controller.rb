module Workarea
  module Admin
    class CatalogGiftWrapsController < ApplicationController
      before_action :find_gift_wrap, except: :index

      def index
        @gift_wraps =
          Catalog::GiftWrap.page(params[:page]).per(Workarea.config.per_page)
      end

      def new; end

      def create
        if @gift_wrap.save && save_pricing_sku
          flash[:success] =
            t('workarea.admin.catalog_gift_wraps.flash_messages.success')
          redirect_to catalog_gift_wraps_path
        else
          flash[:error] =
            t('workarea.admin.catalog_gift_wraps.flash_messages.error')
          render :new
        end
      end

      def edit
        @pricing = Pricing::Sku.find(@gift_wrap.sku) rescue nil
      end

      def update
        if @gift_wrap.update_attributes(params[:gift_wrap])
          flash[:success] =
            t('workarea.admin.catalog_gift_wraps.flash_messages.success')
          redirect_to catalog_gift_wraps_path
        else
          flash[:error] =
            t('workarea.admin.catalog_gift_wraps.flash_messages.error')
          render :edit
        end
      end

      def destroy
        @gift_wrap.destroy

        flash[:success] =
          t('workarea.admin.catalog_gift_wraps.flash_messages.destroyed')
        redirect_to catalog_gift_wraps_path
      end

      private

      def save_pricing_sku
        pricing_params = params[:pricing_sku]
        return true unless pricing_params[:regular].present?

        pricing_sku = Pricing::Sku.find_or_initialize_by(id: @gift_wrap.sku)

        price = pricing_sku.prices.first || pricing_sku.prices.build
        price.regular = pricing_params[:regular].to_m

        if pricing_params[:tax_code].present?
          pricing_sku.tax_code = pricing_params[:tax_code]
        end

        pricing_sku.save
      end

      def find_gift_wrap
        @gift_wrap =
          if params[:id].present?
            Catalog::GiftWrap.find(params[:id])
          else
            Catalog::GiftWrap.new(params[:gift_wrap])
          end
      end
    end
  end
end
