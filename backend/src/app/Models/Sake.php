<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sake extends Model
{
    use HasFactory;

    protected $table = 'sakes';

    protected $fillable = [
        'name', 'area', 'content', 'category_id', 'image',
    ];
    
}
