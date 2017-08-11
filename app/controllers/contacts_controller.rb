class ContactsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    if params[:letter]
      @contacts = Contact.by_letter(params[:letter])
    else
      @contacts = Contact.order('lastname, firstname')
    end
  end

  def show
  end

  def edit
  end

  def new
    @contact = Contact.new
    %w(home office mobile).each do |phone|
      @contact.phones.build(phone_type: phone)
    end
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: "Great success in creation." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end




end
